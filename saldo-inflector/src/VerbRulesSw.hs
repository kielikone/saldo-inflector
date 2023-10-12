----------------------------------------------------------------------
-- |
-- Module      : VerbRulesSw
-- Maintainer  : Markus Forsberg
-- Stability   : (stability)
-- Portability : (portability)
--
--
-- Swedish verb functions
-------------------------------------------------------------------------

module VerbRulesSw where

import GenRulesSw
import NounRulesSw(mk_case)
import AdjRulesSw(mk_adj_pos)
import General
import TypesSw

infer_pret_part :: String -> AdjFormPos -> [String]
infer_pret_part bunden = mk_adj_pos [bunden] [bundet] [bundna] [bundna] where
  (bundet,bundna) = case reverse bunden of
    'd':'a':_ -> (bunde ++ "t",  bunden ++ "e")
    'n':'e':_ -> (bund  ++ "et", ungeminate_m_n bund ++ "na") -- fun-na, kom-na
    'd':'d':_ -> (bund  ++ "tt", bunden ++ "a") 
    't':'t':_ -> (bunden,        bunden ++ "a")
    'd':_     -> (bunde ++ "t",  bunden ++ "a")
    _         -> (bunden,        bunden ++ "a")
  bunde = tk 1 bunden
  bund  = tk 2 bunden


mk_verb :: String -> String -> String -> String -> String -> String -> String -> String -> Verb
mk_verb finna finner finne finn fann funne funnit funnen = 
    mk_verb_v (lift finna) (lift finner) (lift finne) (lift finn) (lift fann) (lift funne) 
              (lift funnit) (lift funnen)

mk_verb_v :: [String] -> [String] -> [String] -> [String] -> [String] -> [String] -> [String] -> [String] -> Verb
mk_verb_v finna finner finne finn fann funne funnit funnen = strings . mk_v where 
  mk_v v = case v of
    VF (Pres Ind  Act)   -> finner
    VF (Pres Ind SForm)  -> map (+? "s") (map ungeminate finn) -- +? "s"  -- finns/finnes by exception
    VF (Pres Conj v)     -> map (mk_vox v) finne              
    VF (Pret Ind  Act)   -> fann
    VF (Pret Conj Act)   -> funne
    VF (Pret m    SForm) -> map (+? "s") $ mk_v (VF (Pret m Act)) -- +? "s" --- frös - frös ?
    VF Imper             -> map ungeminate finn
    VI (Inf v)           -> map (mk_vox v) finna
    VI (Sup v)           -> map (mk_vox v) funnit
    VI (PtPres c)        -> map (mk_case c) $  
                             map (\s -> ifEndThen (=='a') s (s++"nde") (s++"ende")) finna
    VI (PtPret a c)     -> map (mk_case c) $ concat $ map (\s -> infer_pret_part s a) funnen


verb_prefixed :: Int -> Suffixes -> Suffixes -> Suffixes -> Suffixes -> 
                        Suffixes -> Suffixes -> Suffixes -> Suffixes -> 
                        String -> Verb
verb_prefixed n finna finner finne finn fann funne funnit funnen s = 
  (mk_verb_v (suff finna) (suff finner) (suff finne) (suff finn) 
             (suff fann)  (suff funne)  (suff funnit) (suff funnen))
  where suff = apply_suffixes (tk n s) -- map ((tk n s) ++)

mk_vox :: Vox -> String -> String
mk_vox v s = case v of
               Act   -> s
               SForm -> (ungeminate s) +? "s"

pres_ind_passive :: String -> String -> [(VerbForm, Str)]
pres_ind_passive leka lek = [(VF (Pres Ind SForm), strings (leks ++ lekes))] where
    lekes = [tk 1 leka ++ "es"] -- for glömmes (*glömes)
    leks  = if (dp 1 lek == "s") then [] else [lek ++ "s"] 

pres_verb_er :: String -> String
pres_verb_er fara
  | a /= "a"                              = fara++"r"
  | a == "a" && elem (dp 1 far) ["r"]     = far -- "l" removed, counter example: falla
  | otherwise                 = far ++ "er"
 where a   = dp 1 fara
       far = tk 1 fara

no_active :: Verb -> Verb
no_active v = v `missing` active_forms

no_passive :: Verb -> Verb
no_passive v = v `missing` passive_forms

no_part_pres :: Verb -> Verb
no_part_pres v = missing v part_pres_forms

no_part_pret :: Verb -> Verb
no_part_pret v = v `missing` part_pret_forms

no_konj :: Verb -> Verb
no_konj v = v `missing` conj_forms

verb_irreg :: String -> String -> String -> String -> String -> Verb
verb_irreg finna finner fann funnit funnen = 
    mk_verb finna finner finne finn fann (funn ++ "e") funnit funnen
      `excepts` if_a (pres_ind_passive finna finn) []
 where
   if_a a b = if dp 1 finna == "a" then a else b
   finn   = if_a (tk 1 finna) finna
   finne  = if_a (finn ++ "e") finn
   funn   = tk 2 funnit
   funna  = ungeminate funn +? "na"     

verb_strong :: String -> String -> String -> Verb
verb_strong finna fann funnit = 
    verb_irreg finna (pres_verb_er finna) fann funnit (tk 2 funnit ++ "en")

verb_short_long :: String -> Verb -> Verb
verb_short_long ge giva = 
    giva `variant` 
             ([(VF (Pres Ind Act),  ge ++ "r"), 
              (VF (Pres Ind SForm), ge ++ "s"),
              (VF Imper,ge)] ++ 
              [ (VI (Inf v),mk_vox v ge) | v <- values])

verb_strong_vowel :: String -> String -> String -> Verb
verb_strong_vowel a u finna = verb_strong finna fann funnit where
  (f,_,nn) = find_stem_vowel (tk 1 finna)
  fann     = ungeminate $ f ++ a ++ nn
  funnit   = f ++ u ++ nn ++ "it"

-- Conjugation 1

vb1 :: String -> Verb
vb1 hoppa =  mk_verb hoppa           (hoppa ++ "r")  (tk 1 hoppa ++ "e") hoppa 
                     (hoppa ++ "de") (hoppa ++ "de") (hoppa ++ "t")      (hoppa ++ "d")

-- Conjugation 2

vb2 :: String -> Verb
vb2 leka = mk_verb leka  leker leke lek   lekde lekde lekt lekd `excepts` pres_ind_passive leka lek
 where
   stam  = tk 1 leka
   leke  = stam ++ "e"
   lek   = ungeminate stam
   lekd  = let lek = ungeminate_m_n stam in case reverse lek of
             t:v:b | elem t "dt" && not (is_vowel v) -> lek   -- sände  
             t:_   | is_voiced t -> lek ++ "d"
             _                   -> lek ++ "t" 
   lekt  = let (dd,el) = span (=='d') (reverse lekd) in 
             reverse el ++ replicate (length dd) 't' 
   lekde = lekd ++ "e"
   leker = pres_verb_er leka

vb2följa  = vb2
vb2sända  = vb2
vb2knäcka = vb2
vb2vända  = vb2
vb2dröja  = vb2

vb2göra :: String -> Verb
vb2göra  göra =  
    mk_verb göra gör (gör ++ "e") gör (gjor ++ "de") (gjor ++ "de") 
            (gjor ++ "t") (gjor ++ "d")
 where g = tk 3 göra
       gör   = tk 1 göra
       gjor = g ++ "jor"

-- Conjugation 3

vb3 :: String -> Verb
vb3 bo = mk_verb bo (bo ++ "r") bo bo (bo ++ "dde") (bo ++ "tt") bo (bo ++ "dd")

vb3klä = vb3

-- Conjugation 4

vb4krypa :: String -> Verb
vb4krypa = verb_strong_vowel "ö" "y"

vb4vinna :: String -> Verb
vb4vinna = verb_strong_vowel "a" "u"  

-- vbsitta = vbfinna

vb4falla :: String -> Verb
vb4falla = verb_strong_vowel "ö" "a"

vb4bita :: String -> Verb
vb4bita = verb_strong_vowel "e" "i"

vb4slå :: String -> Verb
vb4slå slå = verb_strong slå (sl++"og") (sl++"agit")
   where sl = tk 1 slå

vb4vina :: String -> Verb
vb4vina = no_part_pret . vb4bita

vb4supa :: String -> Verb
vb4supa  = verb_strong_vowel "ö" "u"  

vb4komma :: String -> Verb
vb4komma = verb_strong_vowel "o" "o" 

vb4fara :: String -> Verb
vb4fara  = verb_strong_vowel "o" "a"

vb4låta :: String -> Verb
vb4låta = verb_strong_vowel "ä" "å"

vb4äta :: String -> Verb
vb4äta  = verb_strong_vowel "å" "ä"

vb4hålla :: String -> Verb
vb4hålla = verb_strong_vowel "ö" "å"

-- semi-productive paradigms

vb4giva :: String -> Verb
vb4giva s v = (tk 2 s) +* verb_short_long "ge" (verb_strong_vowel "a" "i" "giva") v

vb4bliva :: String -> Verb
vb4bliva s v = (tk 3 s) +* verb_short_long "bli" (vb4bita "bliva") v

vb4draga :: String -> Verb
vb4draga s v = (tk 3 s) +* verb_short_long "dra" (vb4fara "draga") v

vb4taga :: String -> Verb
vb4taga s v = (tk 2 s) +* verb_short_long "ta" (vb4fara "taga") v

vb4binda :: String -> Verb
vb4binda s v = (tk 5 s) +* mk_verb "binda" "binder" "binda" "binda" "band" "band" "bundit" "bunden" v

vb4se :: String -> Verb
vb4se s v = (tk 2 s) +* mk_verb "se" "ser" "se" "se" "såg" "såg" "sett" "sedd" v

vb4gå :: String -> Verb
vb4gå s v = (tk 2 s) +* mk_verb "gå" "går" "gå" "gå" "gick" "ginge" "gått" "gången" v

vb4göra :: String -> Verb
vb4göra s v = (tk 4 s) +* mk_verb "göra" "gör" "göre" "gör" "gjorde" "gjorde" "gjort" "gjord" v

vb4stå :: String -> Verb
vb4stå s v = (tk 3 s) +* (mk_verb "stå" "står" "stå" "stå" "stod" "stånde" "stått" "stånden" `missing` part_pret_forms) v

vb4få :: String -> Verb
vb4få s v = (tk 2 s) +* (mk_verb "få" "får" "få" "få" "fick" "finge" "fått" [] `missing` part_pret_forms) v

vb4hava :: String -> Verb
vb4hava s v = (tk 2 s) +* 
               (verb_short_long "ha" (mk_verb "hava" "haver" "have" "hav" "hade" "hade" "haft" []) 
                                     `missing` part_pret_forms) v

vb4vara :: String -> Verb
vb4vara s v = (tk 4 s) +* (mk_verb "vara" "är" "vare" "var" "var" "vore" "varit" [] `missing` passive_forms) v

-- deponent verbs
vbdsynas :: String -> Verb
vbdsynas synas = missing (vb2 (tk 1 synas)) 
                          (part_pres_forms ++ active_forms)

vbdlyckas :: String -> Verb
vbdlyckas lyckas = missing (mk_verb lyckas lyckas lyckas lyckas (lyck++"ades")  
                                  (lyck++"ades") (lyck++"ats") (lyck++"ad"))
                          (part_pres_forms ++ active_forms)
 where lyck = tk 2 lyckas

vbdhoppas :: String -> Verb
vbdhoppas hoppas = missing (vbdlyckas hoppas) part_forms
 where hopp = tk 2 hoppas

vbdnalkas :: String -> Verb
vbdnalkas nalkas = no_konj $ 
  except (missing (mk_verb nalkas nalkas nalkas nalkas (nalk++"ades")  
                         (nalk++"ades") (nalk++"ats") (nalk++"ad")) active_forms)
                  [(VI (PtPres c),mk_case c (nalk++"ande")) | c <- values]
 where nalk = tk 2 nalkas

vbdfärdas :: String -> Verb
vbdfärdas färdas = except (vbdnalkas färdas) [(VI (PtPres Nom),färd++"andes")]
 where färd = tk 2 färdas

vbdvederfås vederfås (VI (Sup SForm)) = mkStr $ tk 1 vederfås ++ "tts"
vbdvederfås _ _ = nonExist

-- pending verbs
vbvkoka :: String -> Verb
vbvkoka koka = combine (vb1 koka) (vb2 koka)

vbvmista :: String -> Verb
vbvmista mista = combine (vb2 mista) (vb1 mista)

vbvbringa :: String -> Verb
vbvbringa bringa = variant (vb1 bringa) $ [(VI (Sup v), mk_vox v bragt) | v <- values] ++
                                          [(VF (Pret m v), mk_vox v (bragt++"e")) | m <- values,
                                                                                    v <- values]
 where bragt = tk 4 bringa ++ "agt"

vbvtala :: String -> Verb
vbvtala tala = variant (vb1 tala) $ [(VI (Sup v), mk_vox v (tal++"t")) | v <- values] ++
                                          [(VF (Pret m v), mk_vox v (tal++"te")) | m <- values,
                                                                                   v <- values]
 where tal = tk 1 tala

-- FIXME: should be pending
-- vbvsprida :: String -> Verb
-- vbvsprida = vb2 
