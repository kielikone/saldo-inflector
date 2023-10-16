module OtherBuildSw where

import General
import Dictionary
import TypesSw
import RulesSw
import GenRulesSw

-- Proper names

pm_m :: String -> String -> Entry
pm_m tax s = entryI (mk_pm s) [prValue MascGen,tax] 

pm_f :: String -> String -> Entry
pm_f tax s = entryI (mk_pm s) [prValue FemGen,tax] 

pm_h :: String -> String -> Entry
pm_h tax s = entryI (mk_pm s) [prValue Human,tax] 

pm_w :: String -> String -> Entry
pm_w tax s = entryI (mk_pm s) [prValue PNeutr,tax] 

pm_p :: String -> String -> Entry
pm_p tax s = entryI (mk_pm s) [prValue GPl,tax] 

pm_v :: String -> String -> Entry
pm_v tax s = entryI (mk_pm s) [prValue Pend,tax] 

pm_u :: String -> String -> Entry
pm_u tax s = entryI (mk_pm s) [prValue Utr,tax]

pm_n :: String -> String -> Entry
pm_n tax s = entryI (mk_pm s) [prValue Neutr,tax]

pma_n :: String -> String -> Entry
pma_n tax s = entryI (mk_pma s) [prValue Neutr,tax]

pma_u :: String -> String -> Entry
pma_u tax s = entryI (mk_pma s) [prValue Utr,tax]

pma_h :: String -> String -> Entry
pma_h tax s = entryI (mk_pma s) [prValue Human,tax]

pma_w :: String -> String -> Entry
pma_w tax s = entryI (mk_pma s) [prValue PNeutr,tax] 

pma_m :: String -> String -> Entry
pma_m tax s = entryI (mk_pma s) [prValue PNeutr,tax] 

-- multi-word proper names

pmm_n :: String -> String -> Entry
pmm_n tax s = entryI (mk_pmm0 (words s)) [prValue Neutr,tax]

pmm_u :: String -> String -> Entry
pmm_u tax s = entryI (mk_pmm0 (words s)) [prValue Utr,tax]

pmm_h :: String -> String -> Entry
pmm_h tax s = entryI (mk_pmm0 (words s)) [prValue Human,tax]

pmm_m :: String -> String -> Entry
pmm_m tax s = entryI (mk_pmm0 (words s)) [prValue MascGen,tax] 

pmm_f :: String -> String -> Entry
pmm_f tax s = entryI (mk_pmm0 (words s)) [prValue FemGen,tax] 

pmm_v :: String -> String -> Entry
pmm_v tax s = entryI (mk_pmm0 (words s)) [prValue Pend,tax] 

pmm_p :: String -> String -> Entry
pmm_p tax s = entryI (mk_pmm0 (words s)) [prValue GPl,tax] 


pmam_m :: String -> String -> Entry
pmam_m tax s = entryI (mk_pmam0 (words s)) [prValue MascGen,tax] 

-- adverbs

ab_inte :: String -> Entry
ab_inte = entry . (const :: Str -> AdverbInvForm -> Str) . mkStr

ab_främst :: String -> Entry
ab_främst = entry . abfrämst

ab_bra :: [String] -> [String] -> [String] -> Entry
ab_bra x y z = entry $ mk_adverb x y z

ab_fint :: String -> Entry
ab_fint = entry  . abfint

ab_1_fort = entry . abfort

abm_i_till_exempel :: String -> Entry
abm_i_till_exempel till_exempel = entry $ abm till_exempel

-- pronouns

pn_jag :: (Suffixes, Suffixes,Suffixes,Suffixes,Suffixes) -> String -> Entry
pn_jag (a,b,c,d,e) s = entry $ mk_pron_jag (a,b,c,d,e) s

pn_nagon :: (Suffixes, Suffixes, Suffixes) -> String -> Entry
pn_nagon (a,b,c) s = entry $ mk_pron_nagon (a,b,c) s

pn_han :: (Suffixes, Suffixes, Suffixes) -> String -> Entry
pn_han (a,b,c) s = entry $ mk_pron_han (a,b,c) s

pn_o_den :: String -> Entry
pn_o_den = entry . mk_pn_o_den

pn_dylik :: String -> Entry
pn_dylik = entry . mk_pron_dylik

pn_interrog_inv :: String -> Entry
pn_interrog_inv = entry . (const :: Str -> InterrogInvForm -> Str) . mkStr

pn_inv :: String -> Entry
pn_inv = entry . (const :: Str -> PronInvForm -> Str) . mkStr

pnm_inv :: String -> Entry
pnm_inv = entry . (const :: Str -> PronMInvForm -> Str) . mkStr

-- numbers

number    ss = entry . mk_number ss

number_ng ss = entry . mk_number_ng ss

nl_n_1 = entry . nln1 

-- invariant closed classes

interj :: String -> Entry
interj = entry . (const :: Str -> InterjForm -> Str) . mkStr

interjm :: String -> Entry
interjm aja_baja = set_pos "inm" $ interj (aja_baja)

conj :: String -> Entry
conj = entry . (const :: Str -> ConjForm -> Str) . mkStr

subj :: String -> Entry
subj = entry . (const :: Str -> SubForm -> Str) . mkStr

prep :: String -> Entry
prep = entry . (const :: Str -> PartForm -> Str) . mkStr

part :: String -> Entry
part = entry . (const :: Str -> PartForm -> Str) . mkStr

inf_mark :: String -> Entry
inf_mark = entry . (const :: Str -> InfMarkForm -> Str) . mkStr

invar :: String -> String -> Entry
invar pos s = set_pos pos $ prep s

-- abbreviations
aba_i_dvs :: String -> Entry
aba_i_dvs = entry . (const :: Str -> ABAForm -> Str) . mkStr

al_o_den :: String -> Entry
al_o_den den = 
 entry $ \(ArticleForm g) -> strings $ 
                              case g of
                                ASgUtr   -> [den]
                                ASgNeutr -> ["det"]
                                APl      -> ["de","dom"]

al_o_en :: String -> Entry
al_o_en _ = entry $ en_article

