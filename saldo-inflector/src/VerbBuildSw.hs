module VerbBuildSw where

import General
import Dictionary
import TypesSw
import RulesSw
import GenRulesSw

verb :: Verb -> Entry
verb = entry 

verbM :: VerbM -> Entry
verbM = entry

verb_fwcf  :: Int -> (Suffixes,Suffixes,Suffixes,Suffixes,
                      Suffixes,Suffixes,Suffixes,Suffixes) -> (String -> Entry)
verb_fwcf n (finna, finne,finner, finn, fann, funne, funnit, funnen) w = 
 verb $ verb_prefixed n finna finner finne finn fann funne funnit funnen w 

verb_wcf  :: Int -> (Suffixes,Suffixes,Suffixes,Suffixes,Suffixes,Suffixes) -> (String -> Entry)
verb_wcf n (finna, finner, finn, fann, funnit, funnen) w = 
 verb $ verb_prefixed n finna finner [] finn fann [] funnit funnen w 

verb_wc :: Int -> [String] -> [String] -> [String] -> 
                  [String] -> [String] -> [String] -> (String -> Entry)
verb_wc n finna finner finn fann funnit funnen w = 
 verb $ verb_prefixed n (map e finna) (map e finner) []
                        (map e finn) (map e fann)  []
                        (map e funnit) (map e funnen) w

verb_dwc :: Int -> [String] -> [String] -> [String] -> [String] -> 
                  [String] -> (String -> Entry)
verb_dwc n finna finn fann funnit funnen w = 
 verb $ no_part_pres $ 
        no_active $ verb_prefixed n (map e finna) [] [] 
                                    (map e finn) (map e fann) [] 
                                    (map e funnit) (map e funnen) w 

verb_dwcf :: Int -> (Suffixes, Suffixes, Suffixes, Suffixes, Suffixes) -> (String -> Entry)
verb_dwcf n (finna,finn,fann,funnit,funnen) w = 
 verb $ no_part_pres $ 
        no_active $ verb_prefixed n finna [] [] finn fann [] funnit funnen w 

-- verbs :: [String] -> Verb -> [Entry]
-- verbs prefs v = map verb [\f -> strings (map (p ++) (unStr (v f))) | p <- prefs] 
-- Conjugation 1

v1 = verb . no_konj . vb1

-- Conjugation 2

v2           = verb . no_konj .vb2
vb_2a_följa  = verb . no_konj .vb2följa
vb_2a_sända  = verb . no_konj .vb2sända
vb_2a_knäcka = verb . no_konj .vb2knäcka
vb_2a_vända  = verb . no_konj .vb2vända
vb_2a_dröja  = verb . no_konj .vb2dröja
vb_2a_göra   = verb  . no_konj .vb2göra

-- Conjugation 3
v3           = verb . no_konj . vb3
vb_3a_klä    = verb . no_konj . vb3klä

-- Conjugation 4
vb_4a_se    = verb  . vb4se
vb_4a_gå    = verb  . vb4gå
vb_4a_bita  = verb  . vb4bita
vb_4m_vina  = verb  . vb4vina
vb_4a_krypa = verb  . vb4krypa
vb_4a_vinna = verb  . vb4vinna
vb_4a_giva  = verb  . vb4giva
vb_4a_binda = verb  . vb4binda
vb_4a_bliva = verb  . vb4bliva
vb_4a_draga = verb  . vb4draga
vb_4a_göra  = verb  . vb4göra
vb_4m_stå   = verb  . vb4stå
vb_4a_slå   = verb  . vb4slå
vb_4a_ta    = verb  . vb4taga
vb_4a_få    = verb  . vb4få
vb_4a_ha    = verb  . vb4hava
vb_4a_vara  = verb  . vb4vara
vb_4a_fara  = verb  . vb4fara
vb_4a_komma = verb  . vb4komma
vb_4a_äta   = verb  . vb4äta
vb_4a_låta  = verb  . vb4låta
vb_4a_falla = verb  . vb4falla
vb_4a_supa  = verb  . vb4supa
vb_4a_hålla = verb  . vb4hålla

-- deponent verbs
vb_1s_hoppas   = verb . no_konj . vbdhoppas
vb_1s_lyckas   = verb . no_konj . vbdlyckas
vb_1s_nalkas   = verb . no_konj . vbdnalkas
vb_1s_färdas   = verb . no_konj . vbdfärdas
vb_2s_synas    = verb . no_konj . vbdsynas
vb_4d_vederfås = verb . no_konj . vbdvederfås

-- pending verbs
vb_va_koka   = verb . no_konj . vbvkoka 
vb_va_mista  = verb . no_konj . vbvmista
-- vb_va_sprida = verb . no_konj . vbvsprida
vb_va_bringa = verb . no_konj . vbvbringa
vb_va_tala   = verb . no_konj . vbvtala

-- verb phrases
--vbm1_p  v pr   = verbM $ \(VM p) -> mapStr (\s -> unwords [s,pr] ) ((vb1 v) p) 
--vbm1_pr v pr r = verbM $ \(VM p) -> mapStr (\s -> unwords [s,pr,r] ) ((vb1 v) p)

