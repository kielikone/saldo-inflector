module NounBuildSw where

import General
import Dictionary
import GenRulesSw
import TypesSw
import RulesSw
import Data.Char

substantive :: Substantive -> Genus -> Entry
substantive n g = entryI (hyphenate_compounds n) [prValue g]

substUtrum   s = substantive s Utr
substNeutrum s = substantive s Neutr
substPl      s = substantive s GPl
substDPl     s = substantive s GDPl
substVack    s = substantive s Pend
substMasc    s = substantive s Utr

noun_f :: Genus -> (Suffixes,Suffixes,Suffixes,Suffixes) -> (String -> Entry)
noun_f g (apa,apan,apor,aporna) s = noun_cf g (apa,apan,apor,aporna,apa) s 

noun_cf :: Genus -> (Suffixes,Suffixes,Suffixes,Suffixes,Suffixes) -> (String -> Entry)
noun_cf g (apa,apan,apor,aporna,ap) s = substantive n_f g 
  where n_f p = (mk_subst_v (suff apa) (suff apan) (suff apor) (suff aporna) (suff ap)) p
        suff    = apply_suffixes s

noun_ng :: Genus -> (Suffixes,Suffixes,Suffixes,Suffixes) -> (String -> Entry)
noun_ng g (apa,apan,apor,aporna) s = substantive (missing n_f [(SF n d Gen) | n <- values, d <- values]) g 
  where n_f p = (mk_subst_v (suff apa) (suff apan) (suff apor) (suff aporna) (suff apa)) p
        suff    = apply_suffixes s

nna :: Genus -> (Suffixes,Suffixes,Suffixes,Suffixes,Suffixes,Suffixes,Suffixes,Suffixes) -> (String -> Entry)
nna g (apa,apas,apan,apans,apor,apors,aporna,apornas) s = set_pos "nna" $ substantive n_f g 
  where n_f p = (mk_nna (suff apa) (suff apas) (suff apan) (suff apans) (suff apor) (suff apors) 
                        (suff aporna) (suff apornas)) p
        suff    = apply_suffixes s . connect s
        connect s end
         | not (null s) && isUpper (last s) = concat [[(f,(':':e)),(f,('-':e)),(f,e)]  | (f,e@(_:_)) <- end] ++
                                               (filter (null . snd) end)
         | otherwise                        = concat [[(f,(':':e)),(f,('-':e))] | (f,e@(_:_)) <- end] ++
                                               (filter (null . snd) end)

noun :: Genus -> [String] -> [String] -> [String] -> [String] -> (String -> Entry)
noun g apa apan apor aporna s = nounC g apa apan apor aporna apa s 

nounC :: Genus -> [String] -> [String] -> [String] -> [String] -> [String] -> (String -> Entry)
nounC g apa apan apor aporna ap s = substantive n_f g 
  where n_f p = (mk_subst_v apa' apan' apor' aporna' ap') p
        suff    = (s ++)
        apa'    = map suff apa
	apan'   = map suff apan
        apor'   = map suff apor
	aporna' = map suff aporna
	ap'     = map suff ap

-- Declension 1
nn1           = substUtrum . RulesSw.nn1
nn1_flicka    = substUtrum . nn1flicka
nn1_kyrka     = substUtrum . nn1kyrka
nn1_gata      = substUtrum . nn1gata
nn1_olja      = substUtrum . nn1olja
nn1_mamma     = substUtrum . nn1mamma
nn1_siffra    = substUtrum . nn1siffra
nn1_dimma     = substUtrum . nn1dimma
nn1_sopor     = substPl    . nn1sopor
nn1_faggorna  = substDPl   . nn1faggorna

-- declension 2
nn2         = substUtrum . RulesSw.nn2
nn2_toker   = substUtrum . nn2toker
nn2_herre   = substUtrum . nn2herre
nn2_vers    = substUtrum . nn2vers
nn2_manöver = substUtrum . nn2manöver
nn2_nyckel  = substUtrum . nn2nyckel
nn2_öken    = substUtrum . nn2öken
nn2_hummer  = substUtrum . nn2hummer
nn2_kam     = substUtrum . nn2kam
nn2_vägnar  = substPl    . nn2vägnar
nn2_stadgar = substPl    . nn2stadgar
nn2_själ    = substUtrum . nn2själ
nn2_brud    = substUtrum . nn2brud
nn2_jord    = substUtrum . nn2jord
nn2_hjälte  = substUtrum . nn2hjälte
nn2_herde   = substUtrum . nn2herde
nn2_by      = substUtrum . nn2by
nn2_fågel   = substUtrum . nn2fågel
nn2_lem     = substUtrum . nn2lem
nn2_moder   = substUtrum . nn2mor
nn2_dotter  = substUtrum . nn2dotter
nn2_fordran = substUtrum . nn2fordran
nn2_verkan  = substUtrum . nn2verkan
nn3_flanell = substVack  . nn3flanell

-- Declension 3
nn3            = substUtrum   . RulesSw.nn3
nn3_gäst       = substUtrum   . nn3gäst
nn3_bygd       = substUtrum   . nn3bygd
nn3_hävd       = substUtrum   . nn3hävd
nn3_kastanj    = substUtrum   . nn3kastanj
nn3_akademi    = substUtrum   . nn3akademi 
nn3_paraply    = substVack    . nn3paraply
nn3_hobby      = substUtrum   . nn3hobby
nn3_vin        = substNeutrum . nn3vin
nn3_paket      = substVack    . nn3paket
nn3_element    = substVack    . nn3element 
nn3_fiber      = substUtrum   . nn3fiber
nn3_kläder     = substPl      . nn3kläder
nn3_kliche     = substUtrum   . nn3kliche 
nn3_musa       = substUtrum   . nn3musa
nn3_gladiolus  = substUtrum   . nn3gladiolus
nn3_tand       = substUtrum   . nn3tand
nn3_land       = substNeutrum . nn3land
nn3_motor      = substUtrum   . nn3motor
nn3_parti      = substNeutrum . nn3parti
nn3_poesi      = substUtrum   . nn3poesi
nn3_museum     = substNeutrum . nn3museum
nn3_bok        = substUtrum . nn3bok 
nn3_fot        = substUtrum . nn3fot
nn3_vän        = substUtrum . nn3vän

-- Declension 4
nn4           = substUtrum . RulesSw.nn4
nn4_studio    = substUtrum . nn4studio
nn_vu_ampere  = substUtrum . nn4ampere         
nn4_bonde     = substUtrum . nn4bonde
-- Declension 5
nn5           = substNeutrum . RulesSw.nn5
nn5_party     = substNeutrum . nn5party
nn5_äpple     = substNeutrum . nn5äpple
nn5_piano     = substNeutrum . RulesSw.nn5
nn5_arbete    = substNeutrum . nn5arbete
nn5_samhälle  = substNeutrum . nn5samhälle
nn5_knä       = substNeutrum . nn5knä
nn5_bi        = substNeutrum . nn5bi
nn5_frö       = substNeutrum . nn5frö
nn5_abc       = substNeutrum . nn5abc
nn5_anmodan   = substUtrum   . nn5anmodan

-- Declension 6
vs_ordförande  = substUtrum   . nn6ordförande
nn6_lager      = substNeutrum . nn6lager
nn6_nummer     = substNeutrum . nn6nummer
nn6_segel      = substNeutrum . nn6lager
nn6            = substNeutrum . RulesSw.nn6
nn6_barn       = substNeutrum . nn6barn
nn6_arv        = substNeutrum . nn6arv
nn6_mil        = substUtrum   . nn6mil
nn6_garage     = substNeutrum . nn6garage
nn6_klientel   = substVack    . nn6klientel
nn6_akademiker = substUtrum   . nn6akademiker
nn6_papper     = substNeutrum . nn6papper
nn6_program    = substNeutrum . nn6program
nn6_kikare     = substUtrum   . nn6kikare
nn_6u_gås      = substUtrum   . nn6gås            
nn_6n_manus    = substNeutrum . nn6manus 
nn_6u_fader    = substUtrum   . nn6far
nn_6n_frx      = substNeutrum . nn6frx
nn_6p_ordalag  = substPl      . nn6ordalag
nn_6u_broder   = substUtrum   . nn6broder
nn_6u_mus      = substUtrum   . nn6mus
nn_6u_vaktman  = substUtrum   . nn6vaktman
nn_6v_borst    = substVack    . nn6borst
-- Declension 7
nn_7u_musical = substUtrum . nn7musical        
nn_7p_jeans   = substPl    . no_singular . nn7musical          

-- pending nouns
nn_vv_trall          = substVack    . nnvtrall
nn_vu_behå           = substUtrum   . nnvbehå
nn_vu_jojo           = substUtrum   . nnvjojo
nn_vn_kansli         = substNeutrum . nnvkansli
nn_vn_faktum         = substNeutrum . nnvfaktum  
nn_vn_distikon       = substNeutrum . nnvdistikon 
nn_vv_abdomen        = substVack    . nnvabdomen
nn_vn_nomen          = substNeutrum . nnvnomen
nn_vn_understatement = substNeutrum . nnvunderstatement 
nn_vu_franc          = substUtrum   . nnvfranc          
nn_vu_cocktail       = substUtrum   . nnvcocktail       
nn_vu_gangster       = substUtrum   . nnvgangster       
nn_vu_partner        = substUtrum   . nnvpartner        
nn_vu_sandwich       = substUtrum   . nnvsandwich       
nn_vn_centrum        = substNeutrum . nnvcentrum        
nn_vn_tempo          = substNeutrum . nnvtempo          
nn_vp_antecedentia   = substPl      . nnvantecedentia   
nn_vn_alfa_abc = substNeutrum . nnvabc
nn_vn_garn     = substNeutrum . nnvgarn
nn_vn_huvud    = substNeutrum . nnvhuvud
nn_vn_kvantum  = substNeutrum . nnvkvantum
nn_vn_spektrum = substNeutrum . nnvspektrum
nn_vu_blinker  = substUtrum   . nnvblinker
nn_vu_dress    = substUtrum   . nnvdress
nn_vu_hambo    = substUtrum   . nnvhambo
nn_vu_kaliber  = substUtrum   . nnvkaliber
nn_vu_klammer  = substUtrum   . nnvklammer
nn_vu_playboy  = substUtrum   . nnvplayboy
nn_vu_roller   = substUtrum   . nnvroller
nn_vu_trio     = substUtrum   . nnvtrio
nn_vv_borr     = substVack    . nnvborr
nn_vv_test     = substVack    . nnvtest

-- irregular nouns
nn_on_narkotikum     = substNeutrum . nnonarkotikum
nn_ou_examen         = substUtrum   . nnoexamen
nn_ou_emeritus       = substUtrum   . nnoemeritus       
nn_ou_fullmäktig     = substUtrum   . nnofullmäktig     
-- nn_op_prestanda      = substPl      . nnoprestanda      
nn_on_öga      = substNeutrum . nnoöga
nn_op_data     = substPl      . nnodata
nn_ou_officer  = substUtrum   . nnoofficer

-- no plural
nn_0u_mjölk          = substUtrum   . nn0 
nn_0n_oväsen         = substNeutrum . nn0oväsen         
nn_0u_tröst          = substUtrum   . nn0tröst          
nn_0u_adel           = substUtrum   . nn0adel           
nn_0u_början         = substUtrum   . nn0början
nn_0n_skum           = substNeutrum . nn0skum         
nn_0u_skam            = substUtrum  . nn0skam
nn_0v_uran           = substVack    . nn0uran           
nn_0u_fåfänga        = substUtrum   . nn0adel        
nn_0u_biologi        = substUtrum   . nn0biologi        
nn_0u_brådska        = substUtrum   . nn0brådska        
nn_0n_smör           = substNeutrum . nn0smör           
nn_0n_kaffe          = substNeutrum . nn0kaffe          
nn_0n_socker         = substNeutrum . nn0socker         
nn_0n_aktinium       = substNeutrum . nn0aktinium       
nn_0u_samverkan      = substUtrum   . nn0januari
nn_0v_manna          = substVack    . nn0manna        
nn_0v_januari        = substVack    . nn0januari        

-- definite nouns
nn_du_kneken     = substUtrum   . nndkneken         
nn_dn_brådrasket = substNeutrum . nndbrådrasket     

-- no inflection
nn_in_vaj      = substNeutrum . nni
nn_iu_avvaktan = substUtrum   . nni
nn_iu_bror     = substUtrum   . nni
nn_iv_hum      = substVack    . nni

-- genitive inflection
nn_gu_februari = substUtrum   . nngfebruari


nn_kol_14 = substNeutrum . nnkol14

-- multi-words abbreviation invar
-- nna_u :: String -> Entry
-- nna_u s =  entryI (nnai s) [prValue Utr]

-- nna_v :: String -> Entry
-- nna_v s =  entryI (nnai s) [prValue Pend]

-- nna_gu :: String -> Entry
-- nna_gu s = entryI (nnga s) [prValue Utr]

-- multi-words 

substM :: (SubstM -> Str) -> Genus -> Entry
substM n g = entryI n [prValue g]

substMUtrum   s = substM s Utr
substMNeutrum s = substM s Neutr
substMPl      s = substM s GPl
substMDPl     s = substM s GDPl
substMVack    s = substM s Pend
substMMasc    s = substM s Utr

-- definite

nnm_du0_vippen :: String -> Entry
nnm_du0_vippen = substMUtrum . nnmdu . words

-- genitive
nnm_gn0_alter_ego :: String -> Entry
nnm_gn0_alter_ego = substMNeutrum . nnmg . words

nnm_gu0_best_man :: String -> Entry
nnm_gu0_best_man = substMUtrum . nnmg . words

-- invariant

noun_m :: Genus -> String -> String -> String -> String  -> Entry
noun_m g s1 s2 s3 s4 = set_pos "nnm" $ nounC g [s1] [s2] [s3] [s4] [] []

nnm_iu0_avvaktan = substMUtrum . nnmi . words

nnm_6na_kort_varsel s = noun_m Neutr (f [adj,w]) (f [adj++"a",(dv w ++ "et")])
                        (f [adj++"a",w]) (f [adj++"a",(dv w ++ "en")])
  where (w:adj:xs) = reverse $ words s
        f [a,w] = unwords (reverse xs ++ [a,w])

nnm_6ua_oplockad_gås s = noun_m Utr (f [adj,w]) (f [adj++"e",w ++ "en"])
                        (f [adj++"e",(vc "ä" w) ++ "s"]) 
                        (f [adj++"e",(vc "ä" w) ++ "sen"])
  where (w:adj:xs) = reverse $ words s
        f  [a,w]  = unwords (reverse xs ++ [a,w])

nnm_0ua_frid s = noun_m Utr (f [adj,w]) (f [adj++"a",(w ++ "en")]) [] []
  where (w:adj:xs) = reverse $ words s
        f  [a,w]  = unwords (reverse xs ++ [a,w])

nnm_3ua_film s =  noun_m Utr (f [adj,w]) (f [adj++"a",w ++ "en"])
                        (f [adj++"a",w++"er"]) (f [adj++"a",w ++ "erna"]) 
  where (w:adj:xs) = reverse $ words s
        f  [a,w]  = unwords (reverse xs ++ [a,w])

nnm_3ua_enarmad_bandit s =  noun_m Utr (f [adj,w]) (f [adj++"e",w ++ "en"])
                        (f [adj++"e",w++"er"]) (f [adj++"e",w ++ "en"]) 
  where (w:adj:xs) = reverse $ words s
        f  [a,w]  = unwords (reverse xs ++ [a,w])

nnm_2ua_pojke s = noun_m Utr (f [adj,w]) (f [adj++"a",(dv w ++ "en")])
                        (f [adj++"a",(dv w ++ "ar")]) (f [adj++"a",(dv w ++ "arna")]) 
  where (w:adj:xs) = reverse $ words s
        f  [a,w]  = unwords (reverse xs ++ [a,w])

nnm_2ua_stol s = noun_m Utr (f [adj,w]) [] --(f [adj++"a",(dv w ++ "en")])
                        (f [adj++"a",w++"ar"]) (f [adj++"a",w ++ "arna"]) 
  where (w:adj:xs) = reverse $ words s
        f  [a,w]  = unwords (reverse xs ++ [a,w])

nnm_0na_fritt_vivre s =  noun_m Neutr (f [adj,w]) (f [(tk  2 adj)++"a",(w ++ "t")]) [] [] 
  where (w:adj:xs) = reverse $ words s
        f  [a,w]  = unwords (reverse xs ++ [a,w])


nnm_gv_modus_vivendi s =  noun_m Pend (f [adj,w]) [] [] [] 
  where (w:adj:xs) = reverse $ words s
        f  [a,w]  = unwords (reverse xs ++ [a,w])

nnm_5pc_göranden_och_låtanden s =  noun_m GPl [] [] 
                        (unwords [w1,och,w2]) (unwords [w1++"a",och,w2++"a"]) 
  where (w1:och:[w2]) =  words s

nnm_gpc_kreti_och_pleti s =  noun_m GPl [] [] (unwords [w1,och,w2])  []
  where (w1:och:[w2]) =  words s
