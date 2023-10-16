module CommandsSw where

import BuildSw
import Frontend
import TypesSw
import GenRulesSw
import General(tk,(+?))
import Dictionary(Entry,emptyEntry,first_mw,last_mw,map_wordforms,set_head,set_pos,set_inhs)

commands :: [(String, [String], [String] -> Entry)]
commands = sal ++ sal_tail

suffix :: Int -> Entry -> String -> Entry
suffix n e s = map_wordforms ((tk n s)++) e

unDEFINED :: String -> Entry
unDEFINED _ = emptyEntry

sal_tail =
 [
  paradigm_h "pm_fph_kleopatra"              ["kleopatra"]            $ pm_f "ph",
  paradigm_h "pm_uls_storgatan"              ["storgatan"]            $ pm_u "ls",
  paradigm_h "pm_noe_harvard"                ["harvard"]              $ pm_n "oe",
  paradigm_h "pm_utz_bambara"                ["bambara"]              $ pm_u "tz",
  paradigm_h "pm_vlg_nordsjön"               ["nordsjön"]             $ pm_v "lg",
  paradigm_h "pm_uoc_operan"                 ["operan"]               $ pm_u "oc",
  paradigm_h "pm_ueh_upplysningen"           ["upplysningen"]         $ pm_u "eh",
  paradigm_h "pm_uaa_viggen"                 ["viggen"]               $ pm_u "aa",
  paradigm_h "pm_naw_titanic"                ["titanic"]              $ pm_n "aw",
  paradigm_h "pm_upm_audhumbla"              ["audhumbla"]            $ pm_u "pm",
  paradigm_h "pm_uog_polisen"                ["polisen"]              $ pm_u "og",
  paradigm_h "pm_uaa_camel"                  ["camel"]                $ pm_u "aa",
  paradigm_h "pm_poc_hepstars"               ["hepstars"]             $ pm_p "oc",
  paradigm_h "pm_naa_keso"                   ["keso"]                 $ pm_n "aa",
  paradigm_h "pm_upa_brunte"                 ["brunte"]               $ pm_u "pa",
  paradigm_h "pm_uop_landsorganisationen"    ["landsorganisationen"]  $ pm_u "op",
  paradigm_h "pm_uoe_kursverksamheten"       ["kursverksamheten"]     $ pm_u "oe",
  paradigm_h "pm_uap_vasaorden"              ["vasaorden"]            $ pm_u "ap",
  paradigm_h "pm_nwm_aktuellt"               ["aktuellt"]             $ pm_n "wm",
  paradigm_h "pm_nop_efta"                   ["efta"]                 $ pm_n "op",
  paradigm_h "pm_nog_skatteverket"           ["skatteverket"]         $ pm_n "og",
  paradigm_h "pm_nog_knesset"                ["knesset"]              $ pm_n "og",
  paradigm_h "pm_nog_interpol"               ["interpol"]             $ pm_n "og",
  paradigm_h "pm_noc_musikforum"             ["musikforum"]           $ pm_n "oc",
  paradigm_h "pm_nla_solsystemet"            ["solsystemet"]          $ pm_n "la",
  paradigm_h "pm_hph_af"                     ["af"]                   $ pm_h "ph",
  paradigm_h "pm_fph_barbro"                 ["barbro"]               $ pm_f "ph",
  paradigm_h "pm_uwa_monalisa"               ["monalisa"]             $ pm_u "wa",
  paradigm_h "pm_upc_ttaps-gruppen"          ["ttaps-gruppen"]        $ pm_u "pc",
  paradigm_h "pm_uop_atlantpakten"           ["atlantpakten"]         $ pm_u "op",
  paradigm_h "pm_uae_keso"                   ["keso"]                 $ pm_u "ae",
  paradigm_h "pm_nwp_charta77"               ["charta77"]             $ pm_n "wp",
  paradigm_h "pm_nos_gais"                   ["gais"]                 $ pm_n "os",
  paradigm_h "pm_nog_efta"                   ["efta"]                 $ pm_n "og",
  paradigm_h "pm_noa_finnair"                ["finnair"]              $ pm_n "oa",
  paradigm_h "pm_nes_vasaloppet"             ["vasaloppet"]           $ pm_n "es",
  paradigm_h "pm_nap_nobelpriset"            ["nobelpriset"]          $ pm_n "ap",
  paradigm_h "pm_naa_camel"                  ["camel"]                $ pm_n "aa",
  paradigm_h "pm_fpm_maria"                  ["maria"]                $ pm_n "pm",
  paradigm_h "pma_woc_od"                    ["od"]                   $ pma_w "oc",
  paradigm_h "pma_nwb_blm"                   ["blm"]                  $ pma_n "wb",
  paradigm_h "pma_nom_svt"                   ["svt"]                  $ pma_n "om",
  paradigm_h "pma_nog_ab"                    ["ab"]                   $ pma_n "og",
  paradigm_h "pma_noa_sas"                   ["sas"]                  $ pma_n "oa",
  paradigm_h "pma_nam_thx"                   ["thx"]                  $ pma_n "am",
  paradigm_h "pma_naf_jas"                   ["jas"]                  $ pma_n "af",
  paradigm_h "pma_naa_lep"                   ["lep"]                  $ pma_n "aa",
  paradigm_h "pma_mph_jr"                    ["jr"]                   $ pma_m "ph",
  paradigm_h "pma_hph_nn"                    ["nn"]                   $ pma_h "ph",
  paradigm_h "pma_noe_gu"                    ["gu"]                   $ pma_n "oe",
  paradigm_h "pma_nlp_eu"                    ["eu"]                   $ pma_n "lp",
  paradigm_h "pma_uwn_dn"                    ["dn"]                   $ pma_u "wn",
  paradigm_h "pma_ntm_cp"                    ["cp"]                   $ pma_n "tm",
  paradigm_h "pma_mpm_st"                    ["st"]                   $ pma_m "pm",
  paradigm_h "pmm_u0wc_fröken_julie"         ["fröken julie"]         $ pmm_u "wc",
  paradigm_h "pmm_u0la_stora_björnen"        ["stora björnen"]        $ pmm_u "la",
  paradigm_h "pmm_n0op_grön_ungdom"          ["grön ungdom"]          $ pmm_n "op",
  paradigm_h "pmm_u0tb_betula_alba"          ["betula alba"]          $ pmm_u "tb",
  paradigm_h "pmm_m0ph_birger_jarl"          ["birger jarl"]          $ pmm_m "ph",
  paradigm_h "pmm_u0oe_svenska_institutionen" ["svenska institutionen"] $ pmm_u "oe",
  paradigm_h "pmm_u0aa_koh_i_noor"           ["koh i noor"]           $ pmm_u "aa",
  paradigm_h "pmm_m0ph_per_olov"             ["per olov"]             $ pmm_m "ph",
  paradigm_h "pmm_m0ph_karl_den_tolfte"      ["karl den tolfte"]      $ pmm_m "ph",
  paradigm_h "pmm_m0ph_el_greco"             ["el greco"]             $ pmm_m "ph",
  paradigm_h "pmm_f0pm_jungfru_maria"        ["jungfru maria"]        $ pmm_f "pm",
  paradigm_h "pmm_n0lf_vita_huset"           ["vita huset"]           $ pmm_n "lf",
  paradigm_h "pmm_m0ph_karl_xii"             ["karl xii"]             $ pmam_m "ph",
  paradigm_h "pmm_h0ph_jonsson_lind"         ["jonsson lind"]         $ pmm_h "ph",
  paradigm_h "pmm_u0tm_parkinsons_sjukdom"   ["parkinsons sjukdom"]   $ pmm_u "tm",
  paradigm_h "pmm_u0op_nysvenska_rörelsen"   ["nysvenska rörelsen"]   $ pmm_u "op",
  paradigm_h "pmm_u0ls_lilla_nygatan"        ["lilla nygatan"]        $ pmm_u "ls",
  paradigm_h "pmm_u0en_big_bang"             ["big bang"]             $ pmm_u "en",
  paradigm_h "pmm_u0aw_cutty_sark"           ["cutty sark"]           $ pmm_u "aw",
  paradigm_h "pmm_n0oc_ebba_grön"            ["ebba grön"]            $ pmm_n "oc",
  paradigm_h "pmm_m0pm_john_blund"           ["john blund"]           $ pmm_m "pm",
  paradigm_h "pmm_m0ph_adam_av_bremen"       ["adam av bremen"]       $ pmm_m "ph",
  paradigm_h "pmm_v0lf_notre_dame"           ["notre dame"]           $ pmm_v "lf",
  paradigm_h "pmm_u0wn_dagens_nyheter"       ["dagens nyheter"]       $ pmm_u "wn",
  paradigm_h "pmm_u0es_davis_cup"            ["davis cup"]              $ pmm_u "es",
  paradigm_h "pmm_u0er_marie_bebådelse"      ["marie bebådelse"]        $ pmm_u "er",
  paradigm_h "pmm_u0eh_franska_revolutionen" ["franska revolutionen"]   $ pmm_u "eh",
  paradigm_h "pmm_u0ag_rolls_royce"          ["rolls royce"]            $ pmm_u "ag",
  paradigm_h "pmm_p0ph_bröderna_grim"         ["bröderna grim"]         $ pmm_p "ph",
  paradigm_h "pmm_m0ph_plinius_d_y"           ["plinius d y"]           $ pmm_m "pa",
  paradigm_h "pmm_m0pa_pelle_svanslös"        ["pelle svanslös"]        $ pmm_m "pa",
  paradigm_h "pmm_f0ph_eva_ek"                ["eva ek"]                $ pmm_f "ph",
  paradigm_h "pmm_uatm_multipel_skleros"      ["multipel skleros"]      $ pmm_u "tm",
  paradigm_h "pmm_uatm_cerebral_pares"        ["cerebral pares"]        $ pmm_u "tm",
  paradigm_h "pmm_pcpm_hugin_och_munin"       ["hugin och munin"]       $ pmm_p "pm",
  paradigm_h "pmm_f1pm_jungfrun_från_orleans" ["jungfrun från orleans"] $ pmm_f "pm",
  paradigm_h "pmm_nu0wn_svenska_dagbladet"    ["svenska dagbladet"]     $ pmm_n "wn",
  paradigm_h "ab_2_bra"                  ["bra"] $ suffix 3 (ab_bra ["bra"] ["bättre"] ["bäst"]),
  paradigm_h "ab_2_nära"                 ["nära"] $ 
   suffix 4 (ab_bra ["nära"] ["närmare", "närmre"] ["närmast", "närmst"]),
  paradigm_h "ab_2_mycket"               ["mycket"] $ suffix 6 (ab_bra ["mycket"] ["mer","mera"] ["mest"]),
  paradigm_h "ab_2_länge"                ["länge"] $ suffix 5 (ab_bra ["länge"] ["längre"] ["längst"]),
  paradigm_h "ab_2_illa"                 ["illa"] $ 
    suffix 4 (ab_bra ["illa"] ["sämre","värre"] ["sämst","värst"]),
  paradigm_h "ab_2_gärna"                ["gärna"] $ suffix 5 (ab_bra ["gärna"] ["hellre"] ["helst"]),
  paradigm_h "ab_2_föga"                 ["föga"]  $ suffix 4 (ab_bra ["föga"] ["mindre"] ["minst"]),
  paradigm_h "ab_ik_vidare"              ["vidare"] $
    suffix 1 (ab_bra [] ["e"] []),
  paradigm_h "ab_2_lite"              ["lite"] $
     suffix 4 (ab_bra ["lite"] ["mindre"] ["minst"]),
  paradigm_h "ie_i_att"                  ["att"]            inf_mark,
  paradigm_h "sn_i_om"                   ["om"]             subj,

  --paradigm_h "nl_g_åtta"                 ["åtta"]           number_numeral,
  --paradigm_h "nl_g_sju"                  ["sju"]            number_numeral,
  --paradigm_h "nl_g_femti"                ["femti"]          number_numeral,
  --paradigm_h "nl_g_elva"                 ["elva"]           number_numeral,
  --paradigm_h "nl_g_två"                  ["två"]            number_numeral,
  --paradigm_h "nl_g_tolv"                 ["tolv"]           number_numeral,
  --paradigm_h "nl_g_sex"                  ["sex"]            number_numeral,
  --paradigm_h "nl_g_ii"                   ["ii"]             number_iii,
  --paradigm_h "nl_g_i"                    ["i"]              number_iii,
  --paradigm_h "nl_g_halvannan"            ["halvannan"]      number_numeral,
  --paradigm_h "nl_g_en"                   ["en"]             number_numeral,
  --paradigm_h "nl_g_2"                    ["2"]              number_numeral_inv,
  --paradigm_h "nl_g_1"                    ["1"]              number_numeral_inv,
  --paradigm_h "nl_g_fem"                  ["fem"]            number_numeral,
  --paradigm_h "nl_i_tu"                   ["tu"]             number_numeral_inv,
  --paradigm_h "nl_g_tie"                  ["tie"]            number_numeral,
  paradigm_h "nn_3n_parti"     ["parti"]       nn3_parti,
  paradigm_h "nn_3u_fiber"     ["fiber"]       nn3_fiber,
  paradigm_h "nn_3u_tand"      ["tand"]        nn3_tand,
  paradigm_h "nn_3u_film"      ["film"]  nn3,

  paradigm_h "nn_3u_akademi"   ["akademi"] $
   noun_f Utr  ([e ""], [e "n",e "en"], [e "er"], [e "erna"]),   

  paradigm_h "nn_dn_rubbet"   ["rubbet"] $
   noun_f Neutr ([], [e ""], [], []),   

  paradigm_h "nn_dp_tropikerna"   ["tropikerna"] $
   noun_f GPl ([], [], [], [e ""]),   

  paradigm_h "nn_du_stampen"   ["stampen"] $
   noun_f Utr ([], [e ""], [], []),   

  paradigm_h "nn_np_ordalag"   ["ordalag"] $
   noun_f GPl ([], [], [e ""], [e "en"]),   

  paradigm_h "nn_rp_benvärmare"   ["benvärmare"] $
   noun_f GPl ([], [], [e ""], [(tk 1, "na")]),   

  paradigm_h "nn_rp_griller"   ["griller"] $
   noun_f GPl ([], [], [e ""], [e "na"]),   

  paradigm_h "pn_o_sån" ["sån"] $ 
    pn_nagon ([e ""],[e "t"],[e "a"]),

  paradigm_h "pn_o_varsin" ["varsin"] $ 
    pn_nagon ([e ""],[(tk 1,"tt")],[e "a"]),

  paradigm_h "pn_o_vem" ["vem"] $ pn_inv,

  paradigm_h "pn_o_sig" ["sig"] $
    pn_jag ([],[e ""],[(tk 1,"n")],[(tk 1,"tt")],[(tk 1,"na")]),

  paradigm_h "pn_o_ingen"             ["ingen"] $
   pn_nagon ([e ""],[(tk 1,"t")],[(tk 2,"a")]),

  paradigm_h "pn_o_den"               ["den"]   $
   pn_o_den, --pn_nagon ([e ""],[(tk 1,"t")],[]),

  paradigm_h "pn_o_någon"             ["någon"] $
   pn_nagon ([e "", (tk 3,"n")],[(tk 1,"t"), (tk 3,"t")],[(tk 2,"ra")]),
 paradigm_h "pn_o_ingendera"        ["ingendera"] $
    pn_nagon ([e ""],[(tk 5,"tdera")],[(tk 6,"adera")]),
  paradigm_h "pn_o_vi"                ["vi"] $
    pn_jag ([e ""],[(tk 2, "oss")],[(tk 2,"vår"),(tk 2,"våran")],[(tk 2,"vårt"),(tk 2,"vårat")],[(tk 2,"våra")]),
  paradigm_h "pn_o_de"                ["de"] $
   pn_han ([e ""],[(id,"m"),(vc "o","m")],[e "ras"]),
  paradigm_h "pn_o_varenda"           ["varenda"] $
   pn_nagon ([e ""], [(tk 4, "tenda")],[]),
  paradigm_h "pn_o_vardera"           ["vardera"] $
   pn_nagon ([e ""], [(tk 4, "tdera")],[]),
  paradigm_h "pn_o_varannan"          ["varannan"] $
   pn_nagon ([e ""],[(tk 5,"tannat"),e "t"],[]),
  paradigm_h "pn_o_var"               ["var"] $
   pn_nagon ([e ""],[e "t"],[]),
  paradigm_h "pn_o_samma"             ["samma"] $
   pn_nagon ([e ""],[e ""],[e ""]),
  paradigm_h "pn_o_ni"                ["ni"] $
    pn_jag ([e ""],[(tk 2, "er")],[(tk 2,"er"),(tk 2, "eran")],[(tk 2,"ert"),(tk 2,"erat")],[(tk 2,"era")]),
  paradigm_h "pn_o_mången"            ["mången"] $
   pn_nagon ([e ""],[(tk 1,"t")],[(tk 2,"a")]),
  paradigm_h "pn_o_jag"               ["jag"] $
    pn_jag ([e ""],[(tk 3, "mig"),(tk 3,"mej")],[(tk 3,"min")],[(tk 3,"mitt")],[(tk 3,"mina")]),
  paradigm_h "pn_o_högstdensamme"     ["högstdensamme"]     pn_inv,
  paradigm_h "pn_o_hon"               ["hon"] $
   pn_han ([e ""],[(vc "e","ne")],[(tk 2,"ennes")]),
  paradigm_h "pn_o_han"               ["han"] $
   pn_han ([e ""], [(vc "o","om")], [e "s"]),
  paradigm_h "pn_o_endera"            ["endera"] $
   pn_nagon ([e ""],[(tk 5,"ttdera")],[]),
  paradigm_h "pn_o_ena"               ["ena"]               pn_inv,
  paradigm_h "pn_o_du"                ["du"] $
    pn_jag ([e ""],[(tk 2, "dig"),(tk 2,"dej")],[(tk 2,"din")],[(tk 2,"ditt")],[(tk 2,"dina")]),
  paradigm_h "pn_o_densamma"          ["densamma"] $
    pn_nagon ([e ""],[(tk 6,"tsamma")],[(tk 6,"samma")]),
  paradigm_h "pn_o_denna"             ["denna"] $
   pn_nagon ([e ""],[(tk 3,"tta")],[(tk 3,"ssa")]),
  paradigm_h "pn_o_annan"             ["annan"] $
   pn_nagon ([e ""],[(tk 1,"t")],[(tk 3,"dra")]),
  paradigm_h "al_o_den"               ["den"]               al_o_den,
  paradigm_h "nn_vu_mixer" ["mixer"]  $         
   noun_f Utr  ([e ""], [e "n"], [(id,""), (dv,"ar"),(id,"s")], [(id,"na"), (dv,"arna")]),   

  paradigm_h "nn_vn_medium" ["medium"]  $     
   noun_f Neutr  ([e ""], [(tk 2,"et")], [(tk 2,"er"),(tk 2,"a")], [(tk 2,"erna")]),

 -- paradigm_h "nn_op_glasögon" ["glasögon"]   $     
 --  noun GPl [] [] [""] ["en"],

  --paradigm_h "nn_op_makaroni" ["makaroni"]   $     
  -- noun GPl [] [] [""] ["n"],

  paradigm_h "nn_on_memorandum" ["memorandum"]  $  
   noun_f Neutr ([e ""], [e "", e "et"], [(tk 2, "a")], [(tk 2,"a")]),

  --paradigm_h "nn_3n_drama" ["drama"]   $       
  -- noun_f Neutr ([e ""], [e "t"], [(tk 1,"er")], [(tk 1,"erna")]),

  paradigm_h "nn_1u_åder" ["åder"]    $       
   noun_f Utr ([e ""], [e "n"], [(dv,"or")], [(dv,"orna")]),

  paradigm_h "nn_vu_kart" ["kart"]   $       
   noun Utr [""] ["en"] ["ar",""] ["arna"],

  paradigm_h "nn_vn_mirakel" ["mirakel"]   $      
   noun_f Neutr ([e ""], [(dv,"et")], [(id,""),(dv,"er")], 
                          [(dv,"en"), (dv,"erna")]),

  paradigm_h "nn_0v_trim" ["trim"]  $  
   noun_f Pend  ([e ""], [(geminate,"en"), (geminate,"et")], [], []),

  paradigm_h "nn_0v_tö" ["tö"]  $  
   noun_f Pend  ([e ""], [e "et", e "n", e "t"], [], []),

  paradigm_h "nn_0n_bitumen" ["bitumen"]  $
   noun_f Neutr ([e ""], [(id, ""),(vc "i", "et")], [], []),

  paradigm_h "nn_vn_lexikon" ["lexikon"]  $      
   noun_f Neutr ([e ""], [e "et"], [(id,""),(tk 2,"a")], [e "en"]),

  paradigm_h "nn_2u_slarver" ["slarver"]  $    
   noun_f Utr ([e ""], [e "n"], [(dv,"ar"),(tk 2,"ar")], [(dv,"arna"), (tk 2,"arna")]),

  paradigm_h "nn_2u_bräken" ["bräken"]  $    
   noun_f Utr ([e ""], [e "", (dv, "en")], [(dv,"ar")], [(dv,"arna")]),

 paradigm_h "nn_2u_socken" ["socken"]  $    
   noun_f Utr ([e ""], [(dv, "en")], [(dv,"ar")], [(dv,"arna")]),

  paradigm_h "nn_2u_himmel" ["himmel"]  $     
   noun_f Utr ([e ""], [(tk 3,"len"), (id,"en"),(id,"n")], [(tk 3, "lar")], [(tk 3, "larna")]),

  paradigm_h "nn_4n_fängelse" ["fängelse"]  $    
   noun Neutr [""] ["t"] ["r"] ["rna"],

  paradigm_h "nn_2u_dag" ["dag"]  $      
   noun_f Utr ([e ""], [(id,"en"),(tk 1,"n")], [(id,"ar"),(tk 1,"r")], [(id,"arna"),(tk 1,"rna")]),

  paradigm_h "nn_vu_ponny" ["ponny"]  $      
   noun_f Utr ([e ""], [e "n"], [(tk 1,"ies"),(id,"er")], [e "erna"]),

  paradigm_h "nn_vu_kollega" ["kollega"]  $      
   noun_f Utr ([e ""], [e "n"], [(tk 1,"er"),(tk 1,"or")], [(tk 1,"erna"),(tk 1,"orna")]),

  paradigm_h "nn_vn_kolli" ["kolli"]  $       
   noun Neutr [""] ["t"] ["","n"] ["na"],

  paradigm_h "nn_6u_tum" ["tum"]  $        
   noun Utr [""] ["men"] [""] ["men"],

  paradigm_h "nn_6n_universum" ["universum"]  $    
   noun Neutr [""] ["", "et"] [""] ["en"],

  paradigm_h "nn_0n_gluten" ["gluten"]  $   
   noun Neutr [""] ["et",""] [] [],

  paradigm_h "nn_vu_yard" ["yard"]  $        
   noun Utr [""] ["en"] ["","s"] ["en"],

  paradigm_h "nn_vu_svan" ["svan"]  $         
   noun Utr [""] ["en"] ["ar","or"] ["arna","orna"],

  paradigm_h "nn_vn_tema" ["tema"]  $          
   noun Neutr [""] ["t"] ["n","ta"] ["na","tan"],

  paradigm_h "nn_vn_perfektum" ["perfektum"]  $     
   noun Neutr [""] ["et"] ["","er"] ["en","er"],

  paradigm_h "nn_vn_maximum" ["maximum"]  $      
   noun_f Neutr ([e ""], [e "",e "et",(tk 2, "et")], [(id,""),(tk 2,"a")],[(tk 2,"a"),(id,"en")]),

  paradigm_h "nn_vn_frö" ["frö"]  $         
   noun Neutr [""] ["et","t"] ["er","n"] ["erna","na","en"],

  paradigm_h "nn_3u_materia" ["materia"]  $      
   noun_f Utr ([e ""], [e "n"], [(tk 1,"er")], [(tk 1,"erna")]),

  paradigm_h "nn_0n_delirium" ["delirium"]  $
   noun_f Neutr ([e ""],[e "et", (tk 2, "et")],[],[]),

  paradigm_h "nn_vv_fossil" ["fossil"]  $
   noun Pend [""] ["en","et"] ["er",""] ["erna","en"],

  paradigm_h "nn_vv_libretto" ["libretto"]  $
   noun Pend [""] ["n","t"] ["r","n"] ["rna","na"],

  paradigm_h "nn_vu_safari" ["safari"]  $
   noun Utr [""] ["n"] ["er","s"] ["erna"],

  paradigm_h "nn_vu_bungalow" ["bungalow"]  $
   noun Utr [""] ["en"] ["er","s"] ["erna"],

   paradigm_h "nn_ip_honoratiores" ["honoratiores"]  $
   noun_ng GPl ([],[],[e ""],[]),

  paradigm_h "nn_7u_lady" ["lady"]  $
   noun_f Utr ([e ""], [e "n"],[(tk 1,"ies")],[(tk 1,"ies"),(tk 1,"iesarna")]),

  paradigm_h "nn_6v_kvitten" ["kvitten"]  $
   noun Pend [""] [""] [""] ["a"],

  paradigm_h "nn_vv_franska" ["franska"]  $
   noun_f Pend ([e ""],[e "n",e "t"],[(id,""),(tk 1,"or")], [(id,"na"),(tk 1,"orna")]),

  paradigm_h "nn_4v_folie" ["folie"]  $
   noun Pend [""] ["n","t"] ["r"] ["rna"],

  paradigm_h "nn_3u_donjuan" ["donjuan"]  $
   noun Utr [""] [""] ["er"] ["erna"],

  paradigm_h "nn_2v_finger" ["finger"]  $
   noun_f Pend ([e ""], [(dv,"et"),(id,"n")], [(dv,"ar")],[(dv,"arna")]),

  paradigm_h "nn_2u_biceps" ["biceps"]  $
   noun Utr [""] ["", "en"] ["ar"] ["arna"],

  paradigm_h "nn_1u_ultima" ["ultima"]  $
   noun_f Utr ([e ""], [e "", e "n"], [(tk 1,"or")], [(tk 1,"orna")]),           

  paradigm_h "nn_0n_opium" ["opium"]  $
   noun_f Neutr ([e ""], [(tk 2,"et"),(id,"et")],[],[]),

  paradigm_h "nn_vv_skogsrå" ["skogsrå"]  $
   noun Pend [""] ["et","t","n"] ["r","n"] ["rna","na"],

  paradigm_h "nn_vv_prisma" ["prisma"]  $
   noun_f Pend ([e ""], [e "n",e "t"], [(tk 1, "or"),(tk 1,"er")], [(tk 1,"orna"),(tk 1,"erna")]),

  paradigm_h "nn_vv_hult" ["hult"]   $
   noun Pend [""] ["et","en"] ["","ar","er"] ["arna","erna"],

  paradigm_h "nn_vu_spaniel" ["spaniel"]   $   
   noun Utr [""] ["n"] ["ar","s"] ["arna"],

  paradigm_h "nn_vu_litteraturkanon" ["litteraturkanon"]  $
   noun Utr [""] ["en",""] ["er",""] ["erna"],

  paradigm_h "nn_vu_igloo" ["igloo"]  $
   noun Utr [""] ["n"] ["r","er","s"] ["rna","erna"],

  paradigm_h "nn_vn_alfa_io" ["io"]  $
   set_pos "nn" . nna Neutr ([e ""],[e "s"], [e "t", e "et"],[e "ts", e "ets"],[e "n", e ""],[e "ns",e "s"],[e "na",e "en"],[e "nas",e "ens"]),

  paradigm_h "nn_6n_deponens" ["deponens"]  $
   noun Neutr [""] [""] [""] ["en"],

  paradigm_h "nn_6n_andeväsen" ["andeväsen"]  $
   noun Neutr [""] ["det"] [""] ["a"],

  paradigm_h "nn_5n_altare" ["altare"]  $
   noun_f Neutr ([e ""], [e "t"], [e "n"], [(tk 1,"na")]),

  paradigm_h "nn_3u_geranium" ["geranium"]  $
   noun_f Utr ([e ""],[(tk 2,"en")],[(tk 2,"er")],[(tk 2,"erna")]),

  paradigm_h "nn_2u_timma" ["timma"]  $
   noun Utr [""] ["n"] ["r"] ["rna"],

  paradigm_h "nn_1u_toffel" ["toffel"]  $
   noun_f Utr ([e ""], [e "n"],[(dv,"or")],[(dv,"orna")]),

  --paradigm_h "nn_0v_nickel" ["nickel"]  $
  -- noun_f Pend ([e ""],[(id,"n"),(dv,"et")], [], []),

  paradigm_h "nn_0v_dregel" ["dregel"]  $
   noun_f Pend ([e ""],[(id,"n"), (dv,"et")], [], []),

  paradigm_h "nn_0u_koppar" ["koppar"]  $
   noun Utr [""] ["en","n"] [] [],

  paradigm_h "nn_vv_paraply" ["paraply"]  $
   noun Pend [""] ["et","t","n"] ["er","n"] ["erna","na"],

  paradigm_h "nn_vv_etage" ["etage"]  $
   noun Pend [""] ["t","n"] ["r",""] ["rna","n"],

  paradigm_h "nn_vv_chiffer" ["chiffer"]  $
   noun_f Pend ([e ""],[(dv,"et"),(id,"n")],[(id,""),(dv,"er")],[(dv,"en"),(dv,"erna")]),

  paradigm_h "nn_vv_bolster" ["bolster"]  $
   noun_f Pend ([e ""],[(dv,"et"),(id,"n")],[(id,""),(dv,"ar")],[(dv,"arna"), (dv,"en"),(id,"na")]),

  paradigm_h "nn_vu_teve" ["teve"]  $
   noun Utr [""] ["n"] ["","ar"] ["na","arna"],

  paradigm_h "nn_vu_rhododendron" ["rhododendron"]  $
   noun_f Utr ([e ""], [e "en"], [e "",(tk 2, "er")], [(tk 2, "erna")]),

  paradigm_h "nn_vu_kofot" ["kofot"]  $
   noun_f Utr ([e ""], [e "en"],[(id,"ar"),(umlaut . geminate,"er")],[(id,"arna"),(umlaut . geminate,"erna")]),

  paradigm_h "nn_vu_jourhavande" ["jourhavande"]  $
   noun Utr [""] ["n"] ["","n"] ["na"],

  paradigm_h "nn_vu_jockey" ["jockey"]  $
   noun Utr [""] ["n","en"] ["ar","er","s"] ["arna","erna"],

  paradigm_h "nn_vu_grej" ["grej"]  $
   noun Utr [""] ["en"] ["er","or"] ["erna","orna"],

  paradigm_h "nn_vu_drive" ["drive"]  $
   noun_f Utr ([e ""], [e "n"],[(tk 1,"ar"),(id,"s")],[(tk 1,"arna")]),

  paradigm_h "nn_vu_cello" ["cello"]  $
   noun_f Utr ([e ""], [e "n"],[(id,"r"),(tk 1,"i")],[(tk 1,"orna")]),

  paradigm_h "nn_vn_trauma" ["trauma"]  $
   noun_f Neutr ([e ""], [e "t"],[(id,"n"),(tk 1,"er")],[e "na",(tk 1,"erna")]),

  paradigm_h "nn_vn_stall" ["stall"]  $
   noun Neutr [""] ["et"] ["","ar"] ["en","arna"],

  paradigm_h "nn_vn_pi" ["pi"]  $
   noun Neutr [""] ["et","t"] ["","n"] ["na","en"],

  paradigm_h "nn_vn_paper" ["paper"]  $
   noun Neutr [""] ["et"] ["s",""] ["en"],

  paradigm_h "nn_vn_panorama" ["panorama"]  $
   noun_f Neutr ([e ""], [e "t"],[(id,"n"),(tk 1,"or")],[(tk 1,"orna")]),

  paradigm_h "nn_vn_logi" ["logi"]  $
   noun Neutr [""] ["et","t"] ["er","n"] ["erna","na"],

  paradigm_h "nn_ou_medikus" ["medikus"]  $
   noun_f Utr ([e ""], [e "",e "en"],[(tk 3,"ci")], []),

  --paradigm_h "nn_gn_labour" ["labour"] $
  -- noun Neutr [""] [] [] [],

  paradigm_h "nn_6v_årder" ["årder"]  $
   noun_f Pend ([e ""],[(dv,"et"),(id,"n")], [e ""],[(dv,"en"),(id,"na")]),

  paradigm_h "nn_6v_hästskosöm" ["hästskosöm"]  $
   noun_f Pend ([e ""], [(geminate,"et"),(geminate,"en")], [e ""], [(geminate,"en")]),

  paradigm_h "nn_6u_morbroder" ["morbror"]   $
   noun_f Utr ([e ""],[(tk 1,"dern"),(id,"n")], [(umlaut . tk 1, "der")], [(umlaut . tk 1, "derna")]),

  --paradigm_h "nn_6p_benvärmare" ["benvärmare"]  $
  -- noun_f GPl ([], [], [e ""], [(tk 1,"na")]),

  paradigm_h "nn_6n_pansar" ["pansar"]  $
   noun Neutr [""] ["et"] [""] ["na","en"],

  --paradigm_h "nn_6n_monster" ["monster"]  $
  -- noun_f Neutr ([e ""],[(dv,"et")], [e ""],[(dv,"en"),(dv,"erna")]),

  --paradigm_h "nn_6n_filter" ["filter"]  $
  -- noun_f Neutr ([e ""],[(dv,"et")], [e ""],[(dv,"en"),(dv,"erna")]),

  paradigm_h "nn_3n_center" ["center"]  $
   noun_f Neutr ([e ""],[(dv,"et")],[(dv,"er")],[(dv,"erna")]),

  paradigm_h "nn_6n_ankare" ["ankare"]  $
   noun_cf Neutr ([e ""], [e "t"], [e "",e "n"],[(tk 1,"na")],[(tk 1,"")]),

  paradigm_h "nn_3v_plasma" ["plasma"]  $
   noun_f Pend ([e ""], [e "t", e "n"],[(tk 1,"er")],[(tk 1,"erna")]),

  paradigm_h "nn_3u_papyrus" ["papyrus"]  $
   noun_f Utr ([e ""],[(tk 2,"en"), (id,"en")],[(tk 2,"er")],[(tk 2,"erna")]),

  paradigm_h "nn_3n_alluvium" ["alluvium"]  $
   noun_f Neutr ([e ""],[(id,"et"),(tk 2, "et")],[(tk 2,"er")],[(tk 2,"erna")]),

  paradigm_h "nn_3n_alkali" ["alkali"]  $
   noun Neutr [""] ["t"] ["er"] ["erna"],

  --paradigm_h "nn_3d_tropikerna" ["tropikerna"]  $
  -- noun GDPl [] [] [] [""],

  paradigm_h "nn_2v_skit" ["skit"]  $
   noun Pend [""] ["en","et"] ["ar"] ["arna"],

  paradigm_h "nn_2u_toddy" ["toddy"]  $
   noun_f Utr ([e ""],[e "n"],[e "ar", (tk 1, "ar")],[e "arna", (tk 1,"arna")]),

  paradigm_h "nn_0u_praxis" ["praxis"]  $
   noun Utr [""] ["en",""] [] [],

  paradigm_h "nn_vv_stimulus" ["stimulus"]  $
   noun_f Pend ([e ""], [e "", e "en", e "et"],[(id ,""),(tk 2,"i")], []),

  paradigm_h "nn_vv_rå_gång" ["rå"]  $
   noun Pend [""] ["n","et","t"] ["r"] ["rna"],

  paradigm_h "nn_vv_ringfinger" ["ringfinger"]  $
   noun_f Pend ([e ""],[(dv,"et"),(id,"n")], [(dv,"ar"),(id,"")], [(dv,"arna")]),

  paradigm_h "nn_vv_ordal" ["ordal"]  $
   noun Pend [""] ["et","en"] ["","ier"] ["ierna"],

  paradigm_h "nn_vv_halvankare" ["halvankare"]  $
   noun_f Pend ([e ""], [e "t",e "n"], [e "",e "n"],[(tk 1, "na")]),

  paradigm_h "nn_vu_western" ["western"]  $     
   noun Utr [""] [""] ["","s"] [],

  paradigm_h "nn_vu_torso" ["torso"]  $
   noun_f Utr ([e ""], [e "n"],[(tk 1,"er"),(id,"er"),(id,"r")], [(tk 1,"erna"),(id,"erna"),(id,"rna")]),

  paradigm_h "nn_vu_spång" ["spång"]  $
   noun_f Utr ([e ""], [e "en"],[(id,"ar"),(vc "ä","er")], [(id,"arna"),(vc "ä","erna")]),

  paradigm_h "nn_vu_spann" ["spann"]  $
   noun_f Utr ([e ""], [e "en"],[(id,"ar"),(vc "ä","er")],[(id,"arna"),(vc "ä", "erna")]),

  paradigm_h "nn_vu_scarf" ["scarf"]  $
   noun_f Utr ([e ""], [e "en"],[(id,"ar"),(tk 1,"ves")],[(id,"arna")]),

  paradigm_h "nn_vu_rubel" ["rubel"]  $
   noun_f Utr ([e ""], [e "n"],[(id,""),(dv,"er")],[(dv,"erna")]),

  paradigm_h "nn_vu_ro" ["ro"]   $
   noun Utr [""] ["n"] ["n","r"] ["na","rna"],

  paradigm_h "nn_vu_promovend" ["promovend"]  $
   noun Utr [""] ["en"] ["er","i"] ["erna","i"],

  paradigm_h "nn_vu_preses" ["preses"]  $
   noun_f Utr ([e ""], [e ""],[(tk 2, "ides"),(id,"ar")], [e "arna"]),

  paradigm_h "nn_vu_paria" ["paria"]  $
   noun_f Utr ([e ""], [e "n"],[(id,"s"),(tk 1,"or")],[(tk 1,"orna")]),

  paradigm_h "nn_vu_mikron" ["mikron"]  $
   noun Utr [""] ["en"] ["er",""] ["erna"],

  paradigm_h "nn_vu_lama" ["lama"]  $
   noun_f Utr ([e ""], [e "n"],[(tk 1,"or"),(id,"er")],[(tk 1,"orna"),(id,"erna")]),

  paradigm_h "nn_vu_glass" ["glass"]  $
   noun Utr [""] ["en"] ["ar","er",""] ["en","arna","erna"],

  paradigm_h "nn_vu_gladiolus" ["gladiolus"]  $
   noun_f Utr ([e ""], [e "en"],[(id,""),(tk 2,"er"),(id,"ar")], [(tk 2,"erna"),(id,"arna")]),

  paradigm_h "nn_vu_baby" ["baby"]  $
   noun_f Utr ([e ""], [e "n"],[(id,"ar"),(id,"er"),(tk 1,"ies")], [e "arna",e "erna"]),

  paradigm_h "nn_vu_albino" ["albino"]  $
   noun_f Utr ([e ""], [e "n"],[(tk 1,"er"),(id,"s")],[(tk 1,"erna")]),

  paradigm_h "nn_vn_stånd" ["stånd"]  $
   noun_f Neutr ([e ""], [e "et"],[(id,""),(vc "ä","er")],[(id,"en"),(vc "ä","erna")]),

  paradigm_h "nn_vn_solo" ["solo"]  $
   noun_f Neutr ([e ""], [e "t"],[(id,"n"),(tk 1,"i")], [e "na"]),

  paradigm_h "nn_vn_serum" ["serum"]  $
   noun_f Neutr ([e ""], [e "",e "et"],[(id,""),(tk 2,"a")], [(tk 2,"a"),e "en"]),

  paradigm_h "nn_vn_scenario" ["scenario"]  $
   noun_f Neutr ([e ""], [e "t"],[(id,"n"),(tk 1,"er")],[(id,"na"),(tk 1,"erna")]),

  paradigm_h "nn_vn_rö" ["rö"]  $
   noun Neutr [""] ["t","et"] ["","n"] ["na"],

  paradigm_h "nn_vn_rekviem" ["rekviem"]  $
   noun_f Neutr ([e ""],[(id,""),(tk 1,"t"),(tk 1,"met")],[(id,""),(tk 1,"r")],[(tk 1,"rna")]),

  paradigm_h "nn_vn_omen" ["omen"]  $
   noun_f Neutr ([e ""],[(id,"et"),(tk 2,"inet")],[(id,""),(tk 2,"ina")],[]),

  paradigm_h "nn_vn_mineral" ["mineral"]  $
   noun Neutr [""] ["et"] ["er", "ier"] ["erna","ierna"],

  paradigm_h "nn_vn_lim" ["lim"]  $
   noun Neutr [""] ["met"] ["", "mer"] ["men","merna"],

  paradigm_h "nn_vn_kompositum" ["kompositum"]  $
   noun_f Neutr ([e ""],[(id,""),(tk 2,"et")],[(tk 2,"a"), (tk 2,"er")], [(tk 2,"erna")]),

  paradigm_h "nn_vn_ja" ["ja"]  $
   noun Neutr [""] ["et","t"] ["n", ""] ["na"],

  paradigm_h "nn_vn_härad" ["härad"]  $
   noun Neutr [""] ["et"] ["", "er","en"] ["ena","erna"],

  paradigm_h "nn_vn_gag" ["gag"]  $
   (noun Neutr [""] ["et"] ["s", ""] ["sen","en"]),

  paradigm_h "nn_vn_gage" ["gage"]  $
   noun Neutr [""] ["t"] ["","r"] ["n","rna"],

  paradigm_h "nn_vn_apropå" ["apropå"]   $       
   noun Neutr [""] ["t"] ["n","er"] ["na","erna"],

  paradigm_h "nn_vn_alfa_z" ["z"]  $
   set_pos "nn" . nna Neutr ([e ""],[e "s"], [e "t", e "et"],[e "ts", e "ets"],[e "n", e ""],[e "ns",e "s"],[e "na"],[e "nas"]),
   -- noun Neutr [""] ["-t"] ["","-n"] ["-na"],

  paradigm_h "nn_vn_ackordion" ["ackordion"]  $
   noun_f Neutr ([e ""],[(id,"et"),(tk 2,"et")],[(id,""),(tk 2,"er")],[(tk 2,"erna")]),

  paradigm_h "nn_ov_styck" ["styck"]  $
   noun Pend [""] ["en","et"] ["en"] ["ena"],

  paradigm_h "nn_ov_diktamen" ["diktamen"]  $
   noun_f Pend ([e ""], [e ""],[(tk 2,"ina"),e ""], [(tk 2,"ina"),e ""]),

  paradigm_h "nn_ou_putto" ["putto"]  $
   noun_f Utr ([e ""], [e "n"],[(tk 1,"i")], []),

  paradigm_h "nn_ou_penny" ["penny"]  $
   noun_f Utr ([e ""], [e "n"],[(tk 2,"ce"),(tk 1,"ies")], [(tk 2,"cen")]),

  paradigm_h "nn_ou_mekanikus" ["mekanikus"]  $
   noun_f Utr ([e ""], [e "en"],[(tk 3,"ci")], []),

  paradigm_h "nn_on_slusshuvud" ["slusshuvud"]  $
   noun Neutr [""] ["et"] ["en",""] ["ena"],

  paradigm_h "nn_on_gravamen" ["gravamen"]  $
   noun_f Neutr ([e ""], [e "et"],[(tk 2,"ina")], []),

  paradigm_h "nn_7u_slogan" ["slogan"]  $
   noun Utr [""] [""] ["s"] ["sen","sarna"],

  paradigm_h "nn_7n_skinhead" ["skinhead"]  $
   noun Neutr [""] ["et"] ["s"] ["sen","sarna"],

  paradigm_h "nn_6v_modus" ["modus"]  $
   noun Pend [""] ["","et"] [""] ["en"],

  paradigm_h "nn_6v_data" ["data"]  $
   noun Pend [""] ["n","t"] [""] ["na"],

  paradigm_h "nn_6u_man" ["man"]   $
   noun_f Utr ([e ""], [e "nen"], [(umlaut,""),(id,""),(id,"nar")],[(umlaut,"nen"),(id,"narna")]),

  paradigm_h "nn_6u_iktus" ["iktus"]  $
   noun Utr [""] ["en", ""] [""] ["en"],

  paradigm_h "nn_6n_interregnum" ["interregnum"]  $
   noun_f Neutr ([e ""], [e "et",e ""], [e ""], [e "en"]),

  paradigm_h "nn_5n_ri" ["ri"]  $
   noun Neutr [""] ["et"] ["n"] ["en","na"],

  paradigm_h "nn_3v_gelé" ["gelé"]  $
   noun Pend [""] ["n","t","et"] ["er"] ["erna"],

  paradigm_h "nn_3u_fotnot" ["fotnot"]  $
   noun_f Utr ([e ""], [e "en"], [(id,"er"),(vc "ö","ter")],[(id,"erna"),(vc "ö","terna")]),

  paradigm_h "nn_3u_farao" ["farao"]  $
   noun Utr [""] ["","n"] ["ner"] ["nerna"],

  paradigm_h "nn_3u_eforus" ["eforus"]  $
   noun_f Utr ([e ""], [e ""],[(tk 2,"er")],[(tk 2,"erna")]),

  --paradigm_h "nn_3u_alf" ["alf"]  $
  -- noun Utr [""] ["en"] ["er"] ["erna"],

  paradigm_h "nn_3n_seminarium" ["seminarium"]  $
   noun_f Neutr ([e ""], [e "et",(tk 2, "et")],[(tk 2,"er")],[(tk 2,"erna")]),

  paradigm_h "nn_3n_futurum" ["futurum"]  $
   noun_f Neutr ([e ""], [e "",e "et"],[(tk 2,"er")],[(tk 2,"erna")]),

  --paradigm_h "nn_3n_fiber" ["fiber"]  $
  -- noun_f Neutr ([e ""],[(dv,"et")],[(dv,"er")],[(dv,"erna")]),

  paradigm_h "nn_3n_dominion" ["dominion"]  $
   noun_f Neutr ([e ""], [e ""],[(tk 2,"er")],[(tk 2,"erna")]),

  paradigm_h "nn_3v_aktivum" ["aktivum"]  $
   noun_f Pend ([e ""],[(tk 2,"et"),(tk 2,"en"),(id,"et"),(id,"")],[(tk 2,"er")],[(tk 2,"erna")]),

  paradigm_h "nn_2u_stygger" ["stygger"]  $
   noun_f Utr ([e ""],[(id,"n"),(tk 1,"n")],[(tk 2,"ar")],[(tk 2,"arna")]),

  paradigm_h "nn_2u_förmiddag" ["förmiddag"]  $ 
   noun_f Utr ([e ""],[(id,"en"),(tk 1,"n")],[(id,"ar"),(tk 1,"r")],[(id,"arna"),(tk 1,"rna")]),

  paradigm_h "nn_2u_andur" ["andur"]  $
   noun_f Utr ([e ""], [e "en",e "n"],[(dv,"ar")],[(dv,"arna")]),

  --paradigm_h "nn_2d_geniknölarna" ["geniknölarna"]  $
  -- noun GDPl [] [] [] [""],

  paradigm_h "nn_1v_antibiotika" ["antibiotika"]  $
   noun_f Pend ([e ""], [e "n",e "t"],[(tk 1,"or")],[(tk 1,"orna")]),

  paradigm_h "nn_0v_status" ["status"]  $
   noun Pend [""] ["en","","et"] [] [],

  paradigm_h "nn_0v_hysteri" ["hysteri"]  $
   noun Pend [""] ["n","en","et","t"] [] [],

  paradigm_h "nn_0v_facit" ["facit"]  $
   noun_f Pend ([e ""],[((+?"e"),"n"),((+? "e"), "t")],[],[]),

  paradigm_h "nn_0u_makadam" ["makadam"]  $
   noun_f Utr ([e ""], [(geminate,"en"),(id,"en")], [], []),

  paradigm_h "nn_0u_aorta" ["aorta"]  $
   noun Utr [""] ["","n"] [] [],

  paradigm_h "nn_0n_karborundum" ["karborundum"]  $
   noun Neutr [""] ["","et"] [] [],

  paradigm_h "nn_0n_kammarkollegium" ["kammarkollegium"]  $
   noun_f Neutr ([e ""],[e "",(tk 2,"et")],[],[]),

  paradigm_h "nn_0n_gehenna" ["gehenna"]   $
   noun Neutr [""] ["","t"] [] [],

  paradigm_h "nn_2u_bövel" ["bövel"]  $
   noun_f Utr ([e ""],[e "n",e "en"],[(dv,"ar")],[(dv,"arna")]),

  --paradigm_h "nn_3u_amaryllis" ["amaryllis"]  $
  -- noun_f Utr ([e ""],[e "en"],[(tk 2,"er")],[(tk 2,"erna")]),

  paradigm_h "av_0s_minst" ["minst"]  $ 
   adj 0 ([], [], [], [], [], [e ""], []), 



  paradigm_h "av_0_korkad"            ["korkad"]         av_0_konstlad,
  paradigm_h "av_1_enkel"             ["enkel"]          av_1_vacker,
  paradigm_h "av_in_lurt"             ["lurt"]           av_i_diverse,
  paradigm_h "av_id_norra"            ["norra"]          av_i_diverse,
  paradigm_h "av_im_bemälde"          ["bemälde"]        av_i_diverse,
  paradigm_h "av_ik_smärre"             ["smärre"] 
   $ adj 0 ([], [], [], [], [e ""], [], []), 
  --paradigm_h "av_i_biff"              ["biff"]           av_i_diverse,
  paradigm_h "avm_ix0_diverse"        ["diverse"]        avm_i,
  paradigm_h "avm_io0_diverse"        ["diverse"]        avm_i,
  paradigm_h "avm_ia0_diverse"        ["diverse"]        avm_i,
  paradigm_h "avm_ip0_diverse"        ["diverse"]         avm_i,
  --paradigm_h "av_0_undertecknad"      ["undertecknad"]    av_0_konstlad,
  paradigm_h "av_0_skriftlärd"        ["skriftlärd"]      av_0_konstlad,

  paradigm_h "vb_1s_gillas" ["gillas"]  $
   verb_dwc 2 ["as"] ["as","s"] ["ades"] ["ats"] [],

  paradigm_h "vb_1a_spara" ["spara"]  $ 
   verb_wc 1 ["a"] ["ar",""] [""] ["ade"] ["at"] ["ad"],

  paradigm_h "vb_1a_skapa" ["skapa"]   $
   verb_wc 1 ["a"] ["ar"] [""] ["ade"] ["at"] ["ad","t"],

  paradigm_h "vb_1a_ugnsbaka" ["ugnsbaka"]  $
   verb_wc 1 ["a"] ["ar"] ["a", ""] ["ade"] ["at","t"] ["ad"],

  paradigm_h "vb_1m_vånna" ["vånna"]  $
   verb_fwcf 1 ([e "a"], [],[e "ar"],[e "a"], [e "ade"], [e "e"], [e "at"], []),    

  paradigm_h "vb_1m_kackla" ["kackla"]  $
   verb_wc 1 ["a"] ["ar"] ["a"] ["ade"] ["at"] [],

  paradigm_h "vb_1a_unna" ["unna"]  $
   verb_wcf 1 ([e "a"], [e "ar"], [e "a"], [e "ade"], [e "at"], [(id,"ad"),(tk 1,"t")]),

  paradigm_h "vb_1a_häda" ["häda"]  $
   verb_wc 1 ["a"] ["ar"] ["a"] ["ade"] ["at"] ["ad","d"],

  paradigm_h "vb_4m_ljuda" ["ljuda"] $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "ö","")], [e "it"], []),

  paradigm_h "vb_4a_fara" ["fara"]  $
   verb_wcf 1 ([e "a"], [e ""], [e ""], [(vc "o","")], [e "it"], [e "en"]),

  paradigm_h "vb_2a_leva" ["leva"]  $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "de"], [e "t", e "at"], [e "d"]),

  paradigm_h "vb_2a_stödja" ["stödja"]  $
   verb_wcf 1 ([e "a"], [(tk 1, "er"),(id,"er")], [e ""], [(tk 1, "de")], [(tk 1 . dsuff "j", "tt")], [(tk 1, "d")]),

  paradigm_h "vb_2a_sälja" ["sälja"]  $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "å".tk 1, "de")], [(vc "å".tk 1, "")], [(vc "å" . tk 1,"d")]),

  paradigm_h "vb_2a_säga" ["säga"]  $
   verb_wcf 1 ([(id,"a")], [(id, "er"),(tk 1, "jer")], [e ""], [(vc "a".tk 1,"de"),(vc "a".tk 1,"")], [(vc "a","t")] , [(vc "a", "d")]),

  paradigm_h "vb_2a_motsäga" ["motsäga"]  $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "a". tk 1, "de")], [(vc "a", "t")], [(vc "a","d")]),

  paradigm_h "vb_2a_mista" ["mista"]  $
   verb_wc 1 ["a"] ["er"] [""] ["ade","e"] ["","at"] ["ad"],

  paradigm_h "vb_2a_välja" ["välja"]  $
   let g = vct [("ä","a"),("ö","o")] . tk 1 in 
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(g,"de")], [(g, "t")], [(g,"d")]),

  paradigm_h "vb_2m_hända" ["hända"]  $
   verb_wc 2 ["da"] ["der"] ["d"] ["de"] ["t"] [],

  paradigm_h "vb_2d_må" ["må"] 
   (verb_wc 0 [""] ["r"] [] ["tte"] [] []),

  paradigm_h "vb_2m_gitta" ["gitta"]   
   (verb_wcf 1 ([e "a"],[e "er"],[e ""], [e "e"], [e "at"], [])),    

  paradigm_h "vb_2a_städja" ["städja"] 
   (verb_wcf 2 ([e "ja"], [e "jer",e "er"], [e "j"], [(vc "a","de")],[(vc "a","tt")], [(vc "a","d")])),

  paradigm_h "vb_2a_genmäla" ["genmäla"] 
   (verb_wc 1 ["a"] ["er"] [""] ["de","te"] ["t"] ["d"]),

  paradigm_h "vb_2m_väga" ["väga"]  
   (verb_wc 1 ["a"] ["er"] [""] ["de"] ["t"] []),

  paradigm_h "vb_2m_höta" ["höta"] 
   (verb_wc 1 ["a"] ["ter","er"] [""] ["te"] ["t"] []),

  paradigm_h "vb_2m_glädja" ["glädja"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "a" . tk 1,"de")], [(vc "a" . tk 2, "tt")], [])),

  paradigm_h "vb_2m_böra" ["böra"] 
   (verb_wcf 1 ([e "a"], [e ""], [e ""], [(vc "o", "de")], [(vc "o", "t")], [])),

  paradigm_h "vb_2a_tämja" ["tämja"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "de"], [(id, "t"),(tk 1,"t")], [e "d"])),

  paradigm_h "vb_2a_spörja"           ["spörja"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "o" . tk 1, "de")], [(vc "o" . tk 1, "t")], [(vc "o" . tk 1,"d")])),

  paradigm_h "vb_2s_blygas" ["blygas"]  $  
    (verb_dwc 2 ["as"] ["s","es"] ["des"] ["ts"] []),

  paradigm_h "vb_2s_trivas" ["trivas"]  $ 
   (verb_dwc 2 ["as"] ["s"] ["des"] ["ts"] []),

  paradigm_h "vb_2s_nöjas" ["nöjas"] $ 
   (verb_dwc 2 ["as"] ["as"] ["des"] ["ts"] []),

  paradigm_h "vb_2s_minnas" ["minnas"] $ 
   (verb_dwc 3 ["nas"] ["ns"] ["des"] ["ts"] []),

  paradigm_h "vb_2s_vämjas" ["vämjas"] $ 
   (verb_dwc 3 ["jas"] ["jes","js"] ["jdes","des"] ["jts","ts"] []),

  paradigm_h "vb_2s_töras" ["töras"] $ 
   (verb_dwc 4 ["öras"] ["örs"] ["ordes"] ["orts"] []),

  paradigm_h "vb_2s_rymmas" ["rymmas"] $ 
   (verb_dwc 3 ["mas"] ["s","mes"] ["des"] ["ts"] []),

  paradigm_h "vb_2s_idas" ["idas"] $ 
   (verb_dwc 3 ["das"] ["ds","des"] ["ddes"] ["tts"] []),

  paradigm_h "vb_2s_hövas" ["hövas"] $ 
   (verb_dwc 2 ["as"] ["es"] ["des"] ["ts"] []),

  paradigm_h "vb_2s_glädjas" ["glädjas"] $ 
   (verb_dwc 5 ["ädjas"] ["äds","ädes"] ["addes"] ["atts"] []),

  paradigm_h "vb_2s_giftas" ["giftas"] $ 
   (verb_dwc 2 ["as"] [] ["es"] ["s"] []),

  paradigm_h "vb_2s_skiljas" ["skiljas"] $ 
   (verb_dwc 3 ["jas"] ["js","s","jes"] ["des"] ["ts"] []),

  paradigm_h "vb_va_vika" ["vika"]  
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "e","")], [e "it",e "t"], [e "en"])),

  paradigm_h "vb_va_tvinga" ["tvinga"] 
   (verb_wcf 1 ([e "a"], [e "ar"], [e "a"], [(id,"ade"),(vc "a","")], [e "at"], [e "ad"])),

  paradigm_h "vb_va_löpa" ["löpa"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(id,"te"),(vc "o","p")], [(id,"t"),(vc "u","it")], [e "ad"])),

  paradigm_h "vb_vm_fnysa" ["fnysa"]  
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(id,"te"),(vc "ö","")], [e "t"], [])),

  paradigm_h "vb_vm_avvara" ["avvara"] 
   (verb_wc 1 ["a"] ["ar"] ["a"] ["ade",""] ["it","at"] []),

  paradigm_h "vb_va_växa" ["växa"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e "a"], [e "te"],[(vc "u", "it"),(id,"t")], [(vc "u", "en")])),

  paradigm_h "vb_va_stupa" ["stupa"] 
   (verb_wcf 1 ([e "a"], [e "ar"], [e "a"],[(vc "ö",""),(id,"ade")], [e "at"], [e "ad"])),

  paradigm_h "vb_va_lyda" ["lyda"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e "a"], [(id,"de"),(vc "ö","")], [(tk 1,"tt")], [e "d"])),

  paradigm_h "vb_om_skola" ["skola"] 
   (verb_wcf 1 ([e "a"], [(vc "a" . tk 1, ""),(vc "a","l")], [e "a"], [(vc "u", "le")], [e "t"], [])),

  paradigm_h "vb_vm_snika" ["snika"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e "a"], [(vc "e", ""),(id,"te")], [e "it"], [])),

  paradigm_h "vb_vm_smälla" ["smälla"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "a",""),(id,"de")], [e ""], [])),

  paradigm_h "vb_va_tälja" ["tälja"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(id,"de"),(vc "a","de")], [(id,"t"),(vc "a","alt")], [e "ad"])),

  paradigm_h "vb_va_två" ["två"] 
   (verb_wcf 0 ([e ""], [e "r"], [e ""], [e "dde"], [(id,"tt"),(vc "a","it")],  [e "dd"])),

  paradigm_h "vb_va_smälta" ["smälta"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "a", ""),(id,"e")], [(vc "u","it"),(id,"")], [(vc "u","en")])),

  paradigm_h "vb_va_förmäla" ["förmäla"]  
   (verb_wc 1 ["a"] ["er"] ["l"] ["te","de"] ["t"] ["d"]),

  paradigm_h "vb_va_besvärja" ["besvärja"]  
   (verb_wcf 1 ([e "a"],[(id,"er"),(tk 1,"")],[e ""], [(vc "o" . tk 1, ""),(id,"de")], [(vc "u" . tk 1, "it"),(id,"t")], [e "d"])),

  paradigm_h "vb_om_kunna" ["kunna"]  
   (verb_wc 4 ["unna"] ["an"] [] ["unde"] ["unnat"] []),

  paradigm_h "vb_vm_upphäva" ["upphäva"]       
   (verb_wc 3 ["äva"] ["äver"] ["äv"] ["ävde","ov"] ["ävt"] []),

  paradigm_h "vb_vm_undvara" ["undvara"]  
   (verb_wc 1 ["a"] ["ar"] ["a"] ["ade"] ["at","it"] []),

  paradigm_h "vb_vm_strida" ["strida"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(id,"de"), (vc "e", "")], [(tk 1, "tt"), (id, "it")], [])),

  paradigm_h "vb_vm_sluta" ["sluta"] 
   (verb_wcf 1 ([e "a"],[e "ar"], [e "a"], [(id,"ade"),(vc "ö","")], [e "at"], [])),

  paradigm_h "vb_vm_samvara" ["samvara"]  
   (verb_wc 1 ["a"] ["ar"] ["a"] ["ade"] ["it"] []),

  paradigm_h "vb_vm_ryka" ["ryka"]  
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "ö",""),(id,"te")], [(id,"t"),(vc "u","it")],[])),

  paradigm_h "vb_vm_nysa" ["nysa"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(id,"te"),(vc "ö","")], [(id,"t"),(id,"it"),(vc "u","it")], [])),

  paradigm_h "vb_vm_kvida" ["kvida"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "e", ""),(id,"ade")], [e "it"], [])),

  paradigm_h "vb_vm_klinga" ["klinga"]  
   (verb_wcf 1 ([e "a"], [e "ar"], [e "a"], [(id,"ade"),(vc "a","")], [e "at"], [])),

  paradigm_h "vb_vm_gälla_kastrera"   ["gälla"] 
   (verb_wc 1 ["a"] ["er"] [""] ["de","ade"] ["t","at"] []),

  paradigm_h "vb_vm_gala" ["gala"]  
   (verb_wcf 1 ([e "a"], [e ""], [e "a"], [(vc "o","")], [(id,"it"),(vc "a","t")], [])),

  paradigm_h "vb_vm_duga" ["duga"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "ö",""),(id,"ade")], [(id,"t"),(id,"it")], [])),

  paradigm_h "vb_vm_drösa" ["drösa"]  
   (verb_wc 1 ["a"] ["er"] [""] ["te","ade"] ["at","t"] []),

  paradigm_h "vb_vm_drypa" ["drypa"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "ö","")], [(vc "u","it"),(id,"t")], [])),

  paradigm_h "vb_va_utlöpa" ["utlöpa"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "te"], [e "t"], [(vc "u", "en")])),

  paradigm_h "vb_va_träda" ["träda"]  
   (verb_wcf 1 ([e "a"], [e "er"],[e ""],[e "ade",e "de"], [(id,"at"),(tk 1,"tt")], [e "d"])),

  paradigm_h "vb_va_strypa" ["strypa"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "ö",""),(id,"te")], [e "t"],[e "t"])),

  paradigm_h "vb_va_snusmala" ["snusmala"]  
   (verb_wc 1 ["a"] [""] [""] ["de"] ["t"] ["d","en"]),

  paradigm_h "vb_va_skvätta" ["skvätta"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "a",""),(id,"e")], [e ""], [e "ad"])),

  paradigm_h "vb_va_simma" ["simma"] 
   (verb_wcf 1 ([e "a"], [e "ar"], [e "a"],[(vc "a" . ungeminate ,""),(id,"ade")], [(vc "u","it"), (id,"at")],[(vc "u","en"), (id,"ad")])),

  paradigm_h "vb_va_nästa" ["nästa"] 
   (verb_wc 1 ["a"] ["ar"] ["a"] ["ade","e"] ["at"] ["ad"]),

  paradigm_h "vb_va_mala" ["mala"] 
   (verb_wc 1 ["a"] ["er",""] [""] ["de"] ["t"] ["d","en"]),

  paradigm_h "vb_va_kväda" ["kväda"]  
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "a",""),(id,"de")], [e "it"], [e "en"])),

  paradigm_h "vb_va_klyva" ["klyva"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "ö","")], [e "it",e "t"], [e "en"])),

  paradigm_h "vb_va_gälda" ["gälda"]  
   (verb_wcf 1 ([e "a"], [e "ar"], [e "a"], [e "ade"] , [e "at"], [(vc "u", "en"),(id,"ad")])),

  paradigm_h "vb_va_förse" ["förse"] 
   (verb_wcf 0 ([e ""], [e "r"], [e ""],[(vc "å","g"),(id,"dde")], [e "tt"], [e "dd"])),

  paradigm_h "vb_va_förlöpa" ["förlöpa"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "te"],[(vc "u","it"),(id,"t")], [(vc "u","en"), (id,"t")])),

  paradigm_h "vb_va_framtvinga" ["framtvinga"] 
   (verb_wcf 1 ([e "a"], [e "ar"], [e "a"], [e "ade"],[(vc "u","it"),(id,"at")], [(vc "u","en"),(id, "ad")])),

  paradigm_h "vb_va_tala" ["tala"]  $ 
   (verb_wcf 1 ([e "a"], [e "ar"], [e "a"], [e "ade",e "te"],[e "at",e "t"], [e "ad"])),

  paradigm_h "vb_va_bestrida" ["bestrida"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "e",""),(id,"de")], [(tk 1,"tt"),(id,"it")], [e "en",e "d"])),

  paradigm_h "vb_va_besluta" ["besluta"] 
   (verb_wcf 1 ([e "a"], [e "ar"], [e "a"],[(vc "ö",""),(id,"ade")], [e "at",e "it"], [e "en",e "ad"])),

  paradigm_h "vb_va_begrava" ["begrava"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "o",""),(id,"de")], [e "t",e "it"], [e "en",e "d"])),

  paradigm_h "vb_om_vilja" ["vilja"] 
   (verb_wcf 2 ([e "ja"], [e "l"], [e "ja"], [e "le"],[(vc "e", "at")],[])),

  paradigm_h "vb_om_veta" ["veta"] 
   (verb_wcf 1 ([e "a"],[e ""],[e ""],[(vc "i". tk 1,"sste")], [e "at"],[])),

  paradigm_h "vb_om_måste" ["måste"] 
    (verb_wc 1 ["a"] ["e"] ["a"] ["e"] [""] []),

  paradigm_h "vb_om_heta" ["heta"] 
    (verb_wc 1 ["a"] ["er"] [""] ["te"] ["at"] []),

  paradigm_h "vb_oa_varda" ["varda"]  
    (verb_wcf 1 ([e "a"], [e "er"], [e "a"], [e "e"], [(tk 1,"t")],[(vc "o", "en")])),

  paradigm_h "vb_vs_nypas" ["nypas"] $ 
     (verb_dwcf 2 ([e "as"], [e "s"],[(vc "ö","s"),(id,"tes")], [e "ts",e "its"],[])),

  paradigm_h "vb_vs_dväljas" ["dväljas"]  $ 
     (verb_dwcf 3 ([e "jas"], [e "jes",e "js"],[(vc "a","des"),(id,"jdes")], [(vc "a","ts"),(id,"ts")],[])),

  paradigm_h "vb_4s_vederfaras" ["vederfaras"]  $ 
     (verb_dwcf 2 ([e "as"], [e "s"],[(vc "o","s")], [e "its"],[])),

  paradigm_h "vb_4s_umgås" ["umgås"] $ 
     (verb_dwcf 0 ([e ""], [e ""],[(vc "i".tk 1,"cks")],[(tk 1, "tts")],[])),

  paradigm_h "vb_4s_munhuggas" ["munhuggas"]  $ 
     (verb_dwcf 2 ([e "as"], [e "s",e "es"],[(vc "ö","s")], [e "its"],[])),

  paradigm_h "vb_4s_bitas" ["bitas"]  $ 
     (verb_dwcf 2 ([e "as"], [e "s"],[(vc "e","s")], [e "its"],[])),

  paradigm_h "vb_4s_hållas" ["hållas"] $ 
     (verb_dwcf 2 ([e "as"], [e "s"],[(vc "ö","s")], [e "its"],[])),

  paradigm_h "vb_4s_finnas" ["finnas"]  $ 
     (verb_dwcf 2 ([e "as"], [e "s",e "es"],[(vc "a","s")],[(vc "u","its")],[])),

  paradigm_h "vb_4s_stickas" ["stickas"]  $ 
     (verb_dwcf 2 ([e "as"], [e "s"],[(vc "a","s")],[(vc "u","its")],[])),

  paradigm_h "vb_4s_slåss" ["slåss"]  $ 
     (verb_dwcf 2 ([e "ss"], [e "ss"],[(vc "o","gs")],[(vc "a","gits")],[])),

  paradigm_h "vb_4s_ses" ["ses"]  $ 
     (verb_dwcf 1 ([e "s"], [e "s"],[(vc "å","gs")],[(vc "e","tts")],[])),

  paradigm_h "vb_4s_ges" ["givas"] $ 
     (verb_dwcf 2 ([e "as"], [(vc "e". tk 1, "s")],[(vc "a","s")],[(vc "e". tk 1,"tts")],[])),

  paradigm_h "vb_4m_svälta_1" ["svälta"]  
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "a", "")], [(vc "u", "it")], [])),

  paradigm_h "vb_va_svälta_2" ["svälta"]  
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "a", ""), e "e"], [(vc "u", "it")], [e ""])),

  paradigm_h "vb_4m_förslå" ["förslå"]    
   (verb_wcf 0 ([e ""], [e "r"], [e ""],[(vc "o", "g")],[(vc "a","git")], [])),

  paradigm_h "vb_4a_stjäla" ["stjäla"] 
   (verb_wcf 1 ([e "a"], [e ""], [e ""],[(tk 3, "al")], [(tk 3,"ulit")],[(tk 3,"ulen")])),

  paradigm_h "vb_4m_vara" ["vara"]  
      (verb_fwcf 4 ([e "vara"], [e "vare"],[e "är"],[], [e "var"], [e "vore"], [e "varit"], [])), 

  paradigm_h "vb_4m_sova" ["sova"] 
    (verb_wc 1 ["a"] ["er"] [""] [""] ["it"] []),

  paradigm_h "vb_4m_erfara" ["erfara"] 
    (verb_wcf 1 ([e "a"], [e ""], [e ""],[(vc "o", "")], [e "it"], [])),

  paradigm_h "vb_4a_bli" ["bli"]  vb_4a_bliva,

  paradigm_h "vb_4a_bestå" ["bestå"]     
   (verb_wcf 0 ([e ""], [e "r"], [e ""], [(vc "o", "d")], [e "tt"], [e "nden", e "tt"])),

  paradigm_h "vb_4a_äta" ["äta"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "å", "")], [e "it"], [e "en"])),

  paradigm_h "vb_4a_svära" ["svära"] 
   (verb_wcf 1 ([e "a"], [e "",e "jer"], [e ""], 
               [(vc "o", "")],[(vc "u","it")],[(vc "u", "en")])),

  paradigm_h "vb_4a_emotstå" ["emotstå"] 
   (verb_wcf 0 ([e ""], [e "r"], [e ""],[(vc "o", "d")], [e "tt"], [e "nden"])),

  paradigm_h "vb_4m_sitta" ["sitta"]  
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "a", "")],  [(vc "u", "it")], [])),

  paradigm_h "vb_4a_be" ["be"]  
   (verb_wcf 0 ([e "",e "dja"], [e "r",e "djer"], [e ""],[(vc "o", "d")], [e "tt"], [e "dd"])),

  paradigm_h "vb_4m_ryta" ["ryta"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "ö", "")],[(vc "u", "it")], [])),

  paradigm_h "vb_4m_gråta" ["gråta"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "ä", "")],[e "it"], [])),

  paradigm_h "vb_4m_ligga" ["ligga"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "å" . tk 1, "")],[(vc "e". tk 1, "at")], [])),

  paradigm_h "vb_4m_le" ["le"] 
   (verb_wcf 0 ([e ""], [e "r"], [e ""],[(vc "o", "g")], [e "tt"], [])),

  paradigm_h "vb_4m_bekomma" ["bekomma"]  
   (verb_wcf 1 ([e "a"], [e "er"], [],[(vc "o" . ungeminate, "")], [e "it"], [])),

  paradigm_h "vb_4m_småsvära" ["småsvära"] 
   (verb_wcf 1 ([e "a"], [e "",e "jer"], [e ""], [(vc "o", "")],[(vc "u", "it")], [])),

  paradigm_h "vb_4m_skåpäta" ["skåpäta"] 
   (verb_wcf 1 ([e "a"], [e ""], [e ""],[(vc "o", "")],[(vc "u", "it")], [])),
 
  paradigm_h "vb_4m_förevara" ["förevara"] 
   (verb_wcf 1 ([e "a"], [], [], [e ""], [e "it"], [])),

  paradigm_h "vb_4a_stinga" ["stinga"]  
   (verb_wcf 1 ([e "a"], [e "er"], [], [],[(vc "u","it")],[(vc "u","en")])),

  paradigm_h "vb_4a_förgäta" ["förgäta"] 
   (verb_wcf 1 ([e "a"], [e "er"], [e ""],[(vc "a","")], [e "it"], [e "en"])),

  paradigm_h "vb_3a_trä" ["trä"] 
   (verb_wcf 0 ([e ""], [e "r"], [e ""], [e "dde"], [e "tt"], [e "dd"])),

  paradigm_h "vb_2m_ha" ["ha"]  $ 
              verb_wcf 0 ([e "",e "va"], [e "r",e "ver"], [e ""], [e "de"], [e "ft"], []),

  paradigm_h "av_0_höger" ["höger"] 
   (adj 2 ([e "er"], [e "er"], [e "ra"], [e "ra"], [], [], [])), 

  paradigm_h "av_0_fullmäktig" ["fullmäktig"] 
   (adj 2 ([e ""], [e "t"], [e "a"], [e "a"], [], [], [])), 

  paradigm_h "av_0_världsbäst" ["världsbäst"]  
   (adj 0 ([e ""], [e ""], [e "a"], [e "a"], [], [], [])), 

  paradigm_h "av_0_vareviga" ["vareviga"] 
   (adj 0 ([], [], [e ""], [e ""], [], [], [])), 

  paradigm_h "av_0_sankt" ["sankt"] 
   (adj 0 ([e ""], [e ""], [e "a"], [e "a"], [], [], [])), 

  paradigm_h "av_0_pytteliten" ["pytteliten"] 
   (adj 5 ([e "liten"], [e "litet"], [e "lilla"], [e "små"], [], [], [])), 

  paradigm_h "av_0_blott" ["blott"]   
   (adj 0 ([e ""], [e ""], [e "a"], [e "a"], [], [], [])), 

  paradigm_h "av_0s_innersta" ["innersta"] $ 
   (adj 0 ([], [], [], [], [], [e ""], [])), 

  paradigm_h "av_0s_självaste" ["självaste"] $ 
   (adj 0 ([], [], [], [], [], [], [(tk 1, "a")])), 

  paradigm_h "av_0p_samtliga" ["samtliga"] 
   (adj 0 ([], [], [], [e ""], [], [], [])), 

  paradigm_h "av_0d_nästa" ["nästa"] 
   (adj 0 ([], [], [e ""], [], [], [], [])), 

  paradigm_h "av_0d_enda" ["enda"] 
   (adj 0 ([], [], [e ""], [], [], [], [])), 

  paradigm_h "av_v_ond" ["ond"]  
   (adj 0 ([e ""],[(tk 1,"t")], [e "a"], [e "a"], [(id,"are"), (tk 3, "värre")], [(id,"ast"), (tk 3, "värst")], [(id,"aste"),(tk 3, "värsta")])), 

  paradigm_h "av_v_god" ["god"] 
   (adj 0 ([e ""],[(tk 1,"tt")], [e "a"], [e "a"],[(id,"are"),(tk 3, "bättre")], [(id,"ast"),(tk 3,"bäst")],[(id,"aste"),(tk 3, "bästa")])), 

  paradigm_h "av_2_gammal" ["gammal"] 
   (adj 6 ([e "gammal"], [e "gammalt"], [e "gamla"], [e "gamla"], [e "äldre"], [e "äldst"], [e "äldsta"])), 

   paradigm_h "av_2_bra" ["bra"] 
   (adj 2 ([e "ra"], [e "ra"], [e "ra"], [e "ra"], [e "ättre"], [e "äst"], [e "ästa"])), 

  paradigm_h "av_v_nära" ["nära"]  
   (adj 1 ([e "a"], [e "a"], [e "a"], [e "a"], [e "mare",e "mre"], [e "mast",e "mst"], [e "masta",e "msta"])), 

  paradigm_h "av_v_förnäm" ["förnäm"] 
    (adj 0 ([e ""], [e "t"], [e "a"], [e "a"], [e "are"], [e "st",e "ast"], [e "sta",e "asta"])), 

  paradigm_h "av_v_dålig" ["dålig"] 
    (adj 0 ([e ""], [e "t"], [e "a"], [e "a"], [(tk 5,"sämre"), e "are"], [(tk 5,"sämst"),e "ast"], [(tk 5,"sämsta"), e "asta"])), 

  paradigm_h "av_2k_bakre" ["bakre"] 
    (adj 2 ([], [], [], [], [e "re"], [e "ersta"], [e "ersta"])), 

  paradigm_h "av_2_mycken" ["mycken"] 
     (adj 5 ([e "ycken"], [e "ycket"], [e "yckna"], [e "yckna"], [e "er",e "era"], [e "est"], [e "esta"])), 

  paradigm_h "av_2_liten" ["liten"]  
    (adj 5 ([e "liten"], [e "litet"], [e "lilla"], [e "små"], [e "mindre"], [e "minst"], [e "minsta"])), 

  paradigm_h "av_2_få" ["få"] 
    (adj 0 ([e ""], [e ""], [e ""], [e ""],[(umlaut, "rre")], [(umlaut,"rst")], [(umlaut,"rsta")])), 

  paradigm_h "av_1_orange" ["orange"] 
    (adj 1 ([e "e"], [e "e", e "t", e "et"], [e "a", e "e", e "ea"], [e "a", e "e", e "ea"], [e "are", e "eare"], [e "ast",e "east"], [e "asta", e "easta"])), 

  paradigm_h "av_1_knall" ["knall"] 
    (adj 0 ([e ""], [e ""], [e "a"], [e "a"], [e "are"], [e "ast"], [e "asta"])), 

  paradigm_h "av_1_camp" ["camp"]  
    (adj 0 ([e ""], [], [e "a"], [e "a"], [e "are"], [e "ast"], [e "asta"])), 

  paradigm_h "av_1_beige" ["beige"] 
    (adj 0 ([e ""], [e "t"], [e "",e "a"], [e "",e "a"], 
            [e "are"], [e "ast"], [e "asta"])), 

  paradigm_h "av_1_ball" ["ball"]  $
    adj 0 ([e ""], [e "",e "t"], [e "a"], [e "a"], [e "are"], [e "ast"], [e "asta"]), 

  paradigm_h "nnm_vv0_libretto" ["allt i allo"]  $
   last_mw "nnm" ((noun Pend [""] ["n","t"] ["r","n"] ["rna","na"])),

  paradigm_h "nnm_0v_facit" ["modus vivendi"] $
   last_mw "nnm"  (noun_f Pend ([e ""],[((+?"e"),"n"),((+? "e"), "t")],[],[])),

  paradigm_h "nnm_0v_manna" ["lingua franca"] $
   last_mw "nnm" (noun_f Pend ([e ""],[e "n", e "t"],[],[])),

  paradigm_h "nnm_du0_stampen" ["gordiska knuten"] $
   last_mw "nnm" (noun_f Utr ([],[e ""],[],[])),

  paradigm_h "nnm_vu0_mikron" ["grand danois"] $
   last_mw "nnm" (noun Utr [""] ["en"] ["er",""] ["erna"]),

  paradigm_h "nnm_vu0_trio" ["femme fatale"] $
   last_mw "nnm" (noun Utr [""] ["n"] ["r","s"] ["rna"]),

  paradigm_h "nnm_vu0_bungalow" ["spin off"] $
   last_mw "nnm" (noun Utr [""] ["en"] ["er","s"] ["erna"]),

  paradigm_h "nnm_vv0_pain_riche" ["pain riche"] $
   last_mw "nnm" (noun Pend [""] ["n","t"] ["r",""] ["rna","na"]),

  paradigm_h "nnm_vv0_deja_vu" ["déjá vu"]   $
   last_mw "nnm" (noun Pend [""] ["n","t"] ["r","n"] ["rna","na"]),

  paradigm_h "nnm_rp0_griller" ["scampi fritti"] $
   last_mw "nnm" (noun_f GPl ([], [], [e ""], [e "na"])),   

  --paradigm_h "nnm_vu0_rhododendron" ["grand danois"]  $
  -- last_mw "nnm" (noun Utr [""] ["en"] ["er","en"] ["erna","na"]),

  paradigm_h "nnm_vn0_alfa_z" ["ettstrukna c"]  $
   last_mw "nnm" (nna Neutr ([e ""],[e "s"], [e "t",e "et"],[e "ts", e "ets"],[],[],[],[])),

  paradigm_h "nnm_su0_pojke" ["dödens lammunge"] $
   last_mw "nnm" (noun_f Utr ([e ""], [], [(drop_final_e,"ar")], [(drop_final_e,"arna")])),

  paradigm_h "nnm_su0_tro" ["janssons frestelse"] $
   last_mw "nnm" (noun Utr [""] ["n"] [] []),

  --paradigm_h "nnm_np0_scampi_fritti" ["scampi fritti"]   $
  -- last_mw "nnm" (noun GPl [] [] [""] []),  

   paradigm_h "nnm_7u0_hit" ["negro spiritual"]  $
   last_mw "nnm" (noun Utr [""] ["en"] ["s"] ["sen","sarna"]),  

  --paradigm_h "nnm_np0_pommes_frites" ["pommes frites"]  $  
  -- last_mw "nnm" (noun GPl [] [] [""] ["en"]),  

  paradigm_h "nnm_7n0_skinhead" ["practical joke"]  $
   last_mw "nnm" (noun Neutr [""] ["n"] ["s"] ["sen","sarna"]),  

  paradigm_h "nnm_6u0_yen" ["pol mag"]  $ 
   last_mw "nnm" (noun Utr [""] ["en"] [""] ["en"]),  

  paradigm_h "nnm_6n0_blad" ["flygande tefat"]  $
   last_mw "nnm" (noun Neutr [""] ["en"] [""] ["en"]),  

  paradigm_h "nnm_5n0_ansikte" ["da capo"]  $
   last_mw "nnm" (noun Neutr [""] ["n"] ["n"] ["na"]),  

  paradigm_h "nnm_ip0_honoratiores" ["lika goda kålsupare"]  $
   last_mw "nnm" (noun_ng GPl ([],[],[e ""], [])),  

  paradigm_h "nnm_3u0_film" ["medicine kandidat"]  $
   last_mw "nnm" (noun Utr [""] ["en"] ["er"] ["erna"]),  

  paradigm_h "nnm_2u0_stol" ["vinst- och förlusträkning"]  $ 
   last_mw "nnm" (noun Utr [""] ["en"] ["ar"] ["arna"]),  

  paradigm_h "nnm_2u0_nyckel" ["golden retriever"]  $ 
   last_mw "nnm" (noun_f Utr ([e ""],[e "n"], [(dv,"ar")], [(dv,"arna")])),  

  paradigm_h "nnm_rp1_vägnar" ["fjärilar i magen"]  $ 
   first_mw "nnm" (noun_f GPl ([],[], [e ""], [e "na"])),  

  paradigm_h "nnm_1u0_flicka" ["mul- och klövsjuka"]  $ 
   last_mw "nnm" (noun_f Utr ([e ""],[e "n"], [(tk 1,"or")], [(tk 1,"orna")])),  

  paradigm_h "nnm_0u0_hin" ["hin håle"]  $
    last_mw "nnm" (noun_f Utr ([e ""],[], [], [])),  

  paradigm_h "nnm_0u0_frid" ["rhode islandsås"]  $ 
   last_mw "nnm" (noun_f Utr ([e ""],[e "en"], [], [])),  

  --paradigm_h "nnm_6v0_franska" ["pain riche"]  $ 
  -- last_mw "nnm" (noun_f Pend ([e ""],[e "n",e "t"], [], [])),  

  paradigm_h "nnm_np0_ordalag" ["nordiska språk"]  $ 
   last_mw "nnm" (noun_f GPl ([],[], [e ""], [e "en"])),  

  paradigm_h "nnm_4u0_linje" ["eau de cologne"]  $
   last_mw "nnm" (noun_f Utr ([e ""],[e "n"], [e "r"], [e "rna"])),  

  paradigm_h "nnm_2u1_stol" ["ulv i fårakläder"]  $ 
   first_mw "nnm" (noun_f Utr ([e ""],[e "en"], [e "ar"], [e "arna"])),  

  paradigm_h "nnm_2u0_pojke" ["vandrande pinne"]  $ 
   last_mw "nnm" (noun_f Utr ([e ""],[e "n"], [(drop_final_e,"ar")], [(drop_final_e,"arna")])),  

  paradigm_h "nnm_rp0_vägnar" ["reda pengar"]  $
   last_mw "nnm" (noun_f GPl ([],[], [e ""], [e "na"])),

  paradigm_h "nnm_rp0_kårar" ["kalla kårar"]  $
   last_mw "nnm" (noun_f GPl ([],[], [e ""], [e "na"])),

  paradigm_h "nnm_1u1_flicka" ["fnurra på tråden"]  $ 
   first_mw "nnm" (noun_f Utr ([e ""],[e "n"], [(tk 1,"or")], [(tk 1,"orna")])),  
  paradigm_h "nnm_0u0_tro" ["cherry brandy"]  $ 
   last_mw "nnm" (noun_f Utr ([e ""],[e "n"], [], [])),

  paradigm_h "nnm_0u0_antimateria" ["idé- och lärdomshistoria"]  $
   last_mw "nnm" (noun_f Utr ([e ""],[e "n", (tk 1,"en")], [], [])),

  paradigm_h "nnm_in0_vaj" ["berått mod"]  $
   last_mw "nnm" (noun_ng Neutr ([e ""],[], [], [])),

  paradigm_h "nnm_iu0_vift" ["gilla gång"]  $
   last_mw "nnm" (noun_ng Utr ([e ""],[], [], [])),

  --paradigm_h "nnm_gu0_hin_håle" ["hin håle"] $ 
  -- last_mw "nnm" (noun_f Utr ([e ""],[], [], [])),

  --paradigm_h "nnm_dn0_rasket" ["rasket"] $
  -- last_mw "nnm" (noun_f Neutr ([],[e ""], [], [])),

  paradigm_h "nnm_dn0_rubbet" ["rubbet"] $
   last_mw "nnm" (noun_f Neutr ([],[e ""], [], [])),

  paradigm_h "nna_0v_pcb"  ["pcb"]  $ 
   nna Pend ([e ""],[e "s"], [e "n", e "en",e "t",e "et"],[e "ns", e "ens",e "ts", e "ets"],[],[],[],[]),

  paradigm_h "nna_0n_hk"  ["hk"]  $ 
   nna Neutr ([e ""],[e "s"], [],[],[],[],[],[]),

  paradigm_h "nna_0u_jo"  ["jo"]  $ 
   nna Utr ([e ""],[e "s"], [],[],[],[],[],[]),

  paradigm_h "nna_vv_dna"  ["dna"]  $ 
   nna Pend ([e ""],[e "s"], 
             [e "en", e "et"],[e "ens",e "ets"],
             [e "",e "er"],[e "s",e "ers"],
             [e "na",e "erna"],[e "nas",e "ernas"]
            ),
  paradigm_h "nna_6n_kg"   ["kg"]  $ 
   nna Neutr ([e ""],[e "s"], [],[], [e ""], [], [], []),
  paradigm_h "nna_6u_lp"   ["lp"]  $ 
   nna Utr ([e ""],[e "s"], [e "en"],[e "ens"],
            [e ""],[e "s"],[e "en"],[e "ens"]),
   paradigm_h "nna_in_ex"   ["ex"]  $ 
   nna Neutr ([e ""],[],[],[],[],[],[],[]),
   paradigm_h "nna_6n_ekg"  ["ekg"]  $
   nna Neutr ([e ""],[e "s"], [e "et"],[e "ets"],
            [e ""],[e "s"],[e "en"],[e "ens"]),
  paradigm_h "nna_vn_wc"   ["wc"]  $ 
   nna Neutr ([e ""],[e "s"], 
             [e "et"],[e "ets"],
             [e "",e "er"],[e "s",e "ers"],
             [e "na",e "erna"],[e "nas",e "ernas"]
            ),
  paradigm_h "nna_6v_pm"   ["pm"]  $ 
   nna Pend ([e ""],[e "s"], 
             [e "en", e "et"],[e "ens",e "ets"],
             [e ""],[e "s"],
             [e "na"],[e "nas"]
            ),
  paradigm_h "nna_2u_bh"   ["bh"]  $ 
   nna Utr ([e ""],[e "s"], 
            [e "en",e "n"],[e "ens", e "ns"],
            [e "ar"],[e "ars"],
            [e "arna"],[e "arnas"]
           ),

  paradigm_h "avm_0p0_gul" ["rangen stridig"]  $ 
     last_mw "avm" $ av_1_blek,
  paradigm_h "avm_0a0_diverse" ["ute efter"] $ 
     last_mw "avm" av_i_diverse,
  paradigm_h "avm_0x0_utbrunnen" ["inte oäven"] $ 
     last_mw "avm" (adj 0 ([e ""], [(tk 1,"t")], [(dv,"a")], [(dv,"a")], [], [], [])),
  paradigm_h "avm_0x0_korkad" ["fly förbannad"] $ 
     last_mw "avm" (adj 0 ([e ""], [(tk 1,"t")], [e "e"], [e "e"], [], [], [])),
  paradigm_h "avm_0a0_korkad" ["så kallad"]  $ 
     last_mw "avm" (adj 0 ([e ""], [(tk 1,"t")], [e "e"], [e "e"], [], [], [])),

  paradigm_h "avm_0x0_gul" ["inte så pjåkig"] $ 
     last_mw "avm" (adj 0 ([e ""], [e "t"], [e "a"], [e "a"], [], [], [])),
  paradigm_h "avm_0x0_bred" ["naggande god"]  $ 
     last_mw "avm" (adj 0 ([e ""], [(tk 1,"tt")], [e "a"], [e "a"], [], [], [])),
  paradigm_h "avm_0p1_rund" ["inställd på"]  $ 
     first_mw "avm" (adj 0 ([e ""], [(tk 1,"t")], [], [], [], [], [])),
  paradigm_h "avm_0p1_gul" ["hal som en ål"]  $ 
     first_mw "avm" (adj 0 ([e ""], [e "t"], [], [], [], [], [])),
  paradigm_h "avm_0p1_brydd" ["stadd i"]  $ 
     first_mw "avm" (adj 0 ([e ""], [(tk 2,"tt")], [], [], [], [], [])),
  paradigm_h "avm_0p0_diverse" ["ute efter"]  $ 
     last_mw "avm" av_i_diverse,
  paradigm_h "avm_1p1_bred" ["glad i"]  $ 
     first_mw "avm" (adj 0 ([e ""], [(tk 1,"tt")], [], [], [e "are"], [e "ast"], [e "aste"])),
  paradigm_h "avm_1p1_akut" ["fäst vid"]  $ 
   first_mw "avm" (adj 0 ([e ""], [e ""], [], [], [e "are"], [e "ast"], [e "aste"])),
  paradigm_h "al_o_en" ["en"] $ al_o_en,

  paradigm_h "nn_0n_hindi" ["hindi"]  $
   noun_f Neutr ([e ""], [],[],[]),
  paradigm_h "nn_0n_kol-14" ["kol-14"] $ 
   nn_kol_14,
  paradigm_h "nn_0u_hin" ["hin"]    $
   noun_f Utr ([e ""], [],[],[]),
 paradigm_h "av_0_deputerad" ["deputerad"]  $ (adj 1 ([e "d"], [e "t"], [e "de"], [e "de"], [], [], [])), 

 paradigm_h "nn_6u_yen" ["yen"]    $ 
   noun_f Utr ([e ""], [e "en"],[e ""],[e "en"]),
  paradigm_h "nn_vu_bagis" ["bagis"]  $ 
   noun_f Utr ([e ""], [e "en"],[e "",e "ar"],[e "en",e "arna"]),
  paradigm_h "nn_vu_order" ["order"]  $
   noun_f Utr ([e ""], [e "n"],[(id,""),(dv,"ar")],[e "na", (dv,"arna")]), 
  paradigm_h "nn_vu_minut" ["minut"]  $ 
   noun_f Utr ([e ""], [e "en"],[e "er",e "rar"],[e "erna",e "rarna"]),
  paradigm_h "av_0_uppsutten" ["uppsutten"] $ 
   (adj 2 ([e "en"], [e "et"], [e "na"], [e "na"], [], [], [])), 
  paradigm_h "av_0_uppvikt" ["uppvikt"] $ 
   (adj 0 ([e ""], [e ""], [e "a"], [e "a"], [], [], [])), 
  paradigm_h "av_v_trång" ["trång"] $ 
   (adj 0 ([e ""], [e "t"], [e "a"], [e "a"], [(vc "ä","re"),(id,"are")], 
           [(vc "ä","st"),(id,"ast")], [(vc "ä","ste"),(id,"aste")])), 
  paradigm_h "pnm_x1_vad_än"       ["vad än"]         $ pnm_inv,
  paradigm_h "pnm_i_ditt_och_datt" ["ditt och datt"]  $ pnm_inv,
  paradigm_h "pnm_o_vem_som_helst" ["vem som helst"]  $ pnm_inv,
  paradigm_h "vb_2m_mysa" ["mysa"] $ 
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "te"], [e "t"], []),
  paradigm_h "vb_va_nypa" ["nypa"] $ 
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "ö","")], [(id,"t"),(vc "u","it")], [(id,"t"),(vc "u","en")]),
  paradigm_h "vb_0d_lyster"    ["lyster"]    $ 
   verb_wcf 0 ([], [e ""], [], [], [], []),
  paradigm_h "vb_0d_värdes"    ["värdes"]    $
   verb_wcf 0 ([], [e ""], [], [], [], [(tk 1,"d")]),
  paradigm_h "vb_0d_vederböra" ["vederböra"] $
   verb_wcf 0 ([e ""], [(tk 1,"")], [], [], [], []),
  paradigm_h "vb_0d_nåde"      ["nåde"]      $ 
   verb_fwcf 0 ([], [e ""],[],[], [], [], [], []), 
  paradigm_h "vb_0d_lyss"      ["lyss"]      $ 
   verb_fwcf 0 ([], [],[],[e ""], [], [], [], []), 
  paradigm_h "vb_4d_vederfås"  ["vederfås"]  $ 
    verb_dwc 1 [] [] [] ["tts"] [],
   paradigm_h "vb_4d_sprätta"   ["spritta"]   $ 
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "a","")], [], []),

  paradigm_h "vb_id_månde"     ["månde"]  $ 
   verb_wcf 0 ([], [],[],[e ""], [], []), 

  paradigm_h "vb_2d_torde"     ["torde"] $
   verb_fwcf 2 ([], [(vc "ö","")],[],[], [], [e "de"], [], []), 
  paradigm_h "vb_2d_rädas"     ["rädas"]     $ 
   verb_dwc 2 ["as"] ["as","s"] ["ades"] [] [],
  paradigm_h "nnm_6na_segel" ["kort varsel"] $ nnm_6na_kort_varsel,
  paradigm_h "nnm_6ua_gås"   ["oplockad gås"]  $ nnm_6ua_oplockad_gås,
  paradigm_h "nnm_0ua_frid"           ["fri lejd"]  $ nnm_0ua_frid,
  paradigm_h "nnm_3ua_film"           ["fransysk visit "]  $ nnm_3ua_film,
  paradigm_h "nnm_3ua_enarmad_bandit" ["enarmad bandit"]  $ nnm_3ua_enarmad_bandit,
  paradigm_h "nnm_2ua_pojke" ["finsk pinne"] $ nnm_2ua_pojke,
  paradigm_h "nnm_dpc_göranden_och_låtanden" ["göranden och låtanden"]  $ nnm_5pc_göranden_och_låtanden,
  paradigm_h "nnm_0n0_hindi" ["perpetuum mobile"] $
    last_mw "nnm" (noun_f Neutr ([e ""], [],[],[])),
  paradigm_h "nnm_0na_syre"     ["fritt vivre"]     $ nnm_0na_fritt_vivre,
  --paradigm_h "nnm_gv_modus_vivendi"    ["modus vivendi"]   $ nnm_gv_modus_vivendi,
  paradigm_h "nnm_2ua_stol"            ["varm korv"]       $ nnm_2ua_stol,
  paradigm_h "nnm_npc_kreti_och_pleti" ["kreti och pleti"] $ nnm_gpc_kreti_och_pleti,
  paradigm_h "ava_i_kungl"         ["Kungl."]        $ invar "ava",
  paradigm_h "vba_ia_jfr"          ["jfr"]           $ invar "vba",
  paradigm_h "ppa_i_pga"           ["pga"]           $ invar "ppa",
  paradigm_h "ppm_i_a_la"          ["a la"]          $ invar "ppm",
  --paradigm_h "pna_i_fl"            ["fl"]            $ invar "pna",
  paradigm_h "kna_i_o"             ["o"]             $ invar "kna",
  paradigm_h "snm_i_efter_det_att" ["efter det att"] $ invar "snm",
  paradigm_h "knm_x_ju_ju"         ["ju ju"]         $ invar "knm",
  paradigm_h "knm_i_vare_sig"         ["ju ju"]         $ invar "knm",
  paradigm_h "abm_x1_var_än"       ["var än"]        $ invar "abm",
  paradigm_h "ppm_x1_för_skull"    ["för skull"]     $ invar "ppm",
   paradigm_h "ssm_d2_svinhugg_går_igen" ["svinhugg går igen"] $ invar "ssm",
  paradigm_h "ssm_i1_märk_väl"          ["märk väl"]          $ invar "ssm",
  paradigm_h "ssm_d2_saken_är_biff"     ["saken är biff"]     $ invar "ssm",
  paradigm_h "nlm_gi_tusen_sinom_tusen" ["tusen sinom tusen"] $ invar "nlm"
 ]

sal =
 [
  paradigm_h "ab_1_fort"          ["fort"]            ab_1_fort,
  paradigm_h "ab_i_inte"          ["inte"]            ab_inte,
  paradigm_h "ab_is_främst"       ["främst"]          ab_främst,
  paradigm_h "aba_i_dvs"          ["dvs"]             aba_i_dvs,
  paradigm_h "abm_i_till_exempel" ["till exempel"]    abm_i_till_exempel,
  paradigm_h "av_0_lastgammal"    ["lastgammal"]      av_0_lastgammal,
  paradigm_h "av_0_medelstor"     ["medelstor"]       av_0_medelstor,
  paradigm_h "av_1_akut"          ["akut"]            av_1_akut,
  paradigm_h "av_1_blå"           ["blå"]   $
   (adj 0 ([e ""], [e "tt"], [e "a",e ""], [e "a",e ""], [e "are"], [e "ast"], [e "asta"])), 
  paradigm_h "av_1_bred"          ["bred"]            av_1_glad,
  paradigm_h "av_1_brydd"         ["brydd"]           av_1_högljudd,
  paradigm_h "av_1_grann"         ["grann"]           av_1_tunn,
  paradigm_h "av_1_gul"           ["gul"]             av_1_blek,        
  paradigm_h "av_1_lat"           ["lat"]             av_1_lat,
  paradigm_h "av_1_ny"            ["ny"]              av_1_fri,
  paradigm_h "av_1_rund"          ["rund"]            av_1_hård,
  paradigm_h "av_1_stum"          ["stum"]            av_1_ensam,
  paradigm_h "av_1_utbrunnen"     ["utbrunnen"]       av_1_angelägen,
  paradigm_h "av_i_diverse"       ["diverse"]         av_i_diverse,
  --paradigm_h "av_ik_aktre"        ["aktre"]           av_ik_aktre,
  paradigm_h "in_i_aj"            ["aj"]              interj,
  paradigm_h "inm_i_aja_baja"     ["aja baja"]        interjm,
  paradigm_h "kn_i_och"           ["och"]             conj,

-- grundtal, 
-- genus en, ett
-- ordningstal, 
-- masc-no masc: andra, andre

  paradigm_h "nl_g_halvannan"     ["halvannan"] $
   number ([e ""],[(tk 5,"tannat")],[],[]),
  paradigm_h "nl_g_tu"            ["tu"] $
   number ([e ""],[e ""],[],[]),
  paradigm_h "nl_i_i"             ["i"] $
   number_ng ([e ""],[e ""],[],[]),
  paradigm_h "nl_n_1"             ["1"] $
   nl_n_1, --number ([e ""],[e ""],[e ":a"],[e ":e"]),
  --paradigm_h "nl_n_2"             ["2"] $
  -- number ([e ""],[e ""],[e ":a"],[e ":e"]),
  paradigm_h "nl_n_elva"          ["elva"] $
   number ([e ""],[e ""],[(tk 2, "fte")],[(tk 2, "fte")]),
  paradigm_h "nl_n_en"            ["en"] $
   number ([e ""],[(tk 1, "tt")],[(tk 2, "första")],[(tk 2, "förste")]),
  paradigm_h "nl_n_fem"           ["fem"] $
   number ([e ""],[e ""],[e "te"],[e "te"]),
 -- paradigm_h "nl_n_femti"         ["femti"] $
  -- number ([e ""],[e ""],[e "onde"],[e "onde"]),
  paradigm_h "nl_n_fyra"          ["fyra"] $
   number ([e ""],[e ""],[(tk 3, "järde")],[(tk 3,"järde")]),
  paradigm_h "nl_n_hundra"        ["hundra"] $
   number ([e ""],[e ""],[e "de"],[e "de"]),
  paradigm_h "nl_n_sex"           ["sex"] $
    number ([e ""],[e ""],[(tk 2, "jätte")],[(tk 2,"jätte")]),
  paradigm_h "nl_n_tio"           ["tio"] $
   number ([e ""],[e ""],[e "nde"],[e "nde"]),
  paradigm_h "nl_n_tolv"          ["tolv"] $
   number ([e ""],[e ""],[(tk 1, "fte")],[(tk 1, "fte")]),
  paradigm_h "nl_n_tre"           ["tre"] $
   number ([e ""],[e ""],[e "dje"],[e "dje"]),
  paradigm_h "nl_n_två"           ["två"] $
   number ([e ""],[e ""],[(tk 3, "andra")],[(tk 3, "andre")]),
  paradigm_h "nl_n_åtta"          ["åtta"] $
   number ([e ""],[e ""],[(tk 1, "onde")],[(tk 1, "onde")]),
  --paradigm_h    "nl_g_hundra"        ["hundra"]           number_numeral,
  --paradigm_h    "nl_g_iii"           ["iii"]              number_iii, 
  --paradigm_h    "nl_g_tio"           ["tio"]              number_numeral,
  --paradigm_h    "nl_o_femte"         ["femte"]            number_femte, 
  paradigm_h "nn_0n_babbel"       ["babbel"]        nn_0n_socker,
  paradigm_h "nn_0n_cesium"       ["cesium"] $
   noun_f Neutr ([e ""], [(tk 2,"et"),e "et", e ""], [], []),  
  paradigm_h "nn_0n_kaos"         ["kaos"]          nn_0n_smör,
  paradigm_h "nn_0n_oväsen"       ["oväsen"]        nn_0n_oväsen,
  paradigm_h "nn_0n_toapapper"    ["toapapper"]        nn_0n_socker,
  paradigm_h "nn_0n_raseri"       ["raseri"]        nn_0n_smör,
  paradigm_h "nn_0n_skum"         ["skum"]          nn_0n_skum,
  paradigm_h "nn_0n_syre"         ["syre"]          nn_0n_kaffe,
  paradigm_h "nn_0u_akribi"       ["akribi"]         nn_0u_biologi,
  paradigm_h "nn_0u_antimateria"  ["antimateria"] $
   noun_f Utr ([e ""], [e "n",(tk 1, "en")], [], []),  
  paradigm_h "nn_0u_frid"         ["frid"]          nn_0u_mjölk, 
  paradigm_h "nn_0u_samverkan"    ["samverkan"]     nn_0u_samverkan,
  paradigm_h "nn_0u_skam"         ["skam"]          nn_0u_skam,
  paradigm_h "nn_0u_tro"          ["tro"]           nn_0u_adel, 
  paradigm_h "nn_0v_bikarbonat"   ["bikarbonat"]    nn_0v_uran,
  paradigm_h "nn_0v_manna"        ["manna"]         nn_0v_manna,
 -- paradigm_h "nn_1p_anor"         ["anor"]          nn1_sopor,
  paradigm_h "nn_1u_ros"          ["ros"]           nn1,
  paradigm_h "nn_2u_afton"        ["afton"] $
   noun_f Utr ([e ""],[ e "en"], [(dv,"ar")], [(dv,"arna")]),  
  paradigm_h "nn_2u_bro"          ["bro"]           nn2,
  paradigm_h "nn_2u_dotter"       ["dotter"]          nn2_dotter,
  paradigm_h "nn_2u_fordran"      ["fordran"]         nn2_fordran,
  paradigm_h "nn_2u_verkan"       ["verkan"]          nn2_verkan,
  paradigm_h "nn_2u_fröken"       ["fröken"]          nn2_öken,
  paradigm_h "nn_2u_karl"         ["karl"]  $
   noun_f Utr ([e ""], [e "n",e "en"], [e "ar"], [e "arna"]),  
  paradigm_h "nn_2u_moder"        ["moder"]           nn2_moder,
  paradigm_h "nn_2u_morgon"       ["morgon"] $
   noun_f Utr ([e ""], [e "en"], [(dv,"ar"),e "ar"], [(dv,"arna"),e "arna"]),  
  paradigm_h "nn_2u_mun"          ["mun"]             nn2_kam,
  paradigm_h "nn_3n_gift"         ["gift"]            nn3_vin,
  paradigm_h "nn_3n_land"         ["land"]            nn3_land,
  paradigm_h "nn_3n_museum"       ["museum"]          nn3_museum,
  --paradigm_h "nn_3p_griller"      ["griller"]         nn3_kläder,
  paradigm_h "nn_3u_bok"          ["bok"]             nn3_bok,
  paradigm_h "nn_3u_fot"          ["fot"]             nn3_fot,
  paradigm_h "nn_3u_get"          ["get"]             nn3_fot,
  paradigm_h "nn_3u_historia"     ["historia"] $
   noun_f Utr ([e ""], [(tk 1,"en"),e "n"], [(tk 1, "er")], [(tk 1 ,"erna")]),  
  paradigm_h "nn_3u_kavaljer"     ["kavaljer"]  $
   noun_f Utr ([e ""], [e "en", e "n"], [e "er"], [e "erna"]),  
  paradigm_h "nn_3u_motor"        ["motor"]           nn3_motor,
  paradigm_h "nn_3u_son"          ["son"] $
   (noun_f Utr ([e ""], [e "en"], [(vc "ö","er")], [(vc "ö","erna")])),  
  paradigm_h "nn_3u_stad"         ["stad"] $
   (noun_f Utr ([e ""], [e "en",(tk 1,"n")], [(vc "ä","er")], [(vc "ä","erna")])),  
  paradigm_h "nn_3u_tång"         ["tång"] $
   (noun_f Utr ([e ""], [e "en"], [(vc "ä","er")], [(vc "ä","erna")])),  
  paradigm_h "nn_3u_vän"          ["vän"]             nn3_vän,
  paradigm_h "nn_3v_flanell"      ["flanell"]         nn3_flanell,
  paradigm_h "nn_4u_bonde"        ["bonde"]           nn4_bonde,
  paradigm_h "nn_5n_ansikte"      ["ansikte"]         nn5_arbete,
  paradigm_h "nn_5n_bo"           ["bo"] $
   (noun_f Neutr ([e ""], [e "t", e "et"], [e "n"], [e "en",e "na"])),  
  paradigm_h "nn_5u_anmodan"      ["anmodan"]         nn5_anmodan,
  paradigm_h "nn_6n_aber"         ["aber"] $
   (noun_f Neutr ([e ""], [e "et",(dv,"et")], [(dv,"en")], [(dv, "ena")])),  
  paradigm_h "nn_6n_blad"         ["blad"]            nn6,          
  paradigm_h "nn_6n_foder"        ["foder"]           nn6_lager,
  paradigm_h "nn_6n_frx"          ["frx"]             nn_6n_frx,
  paradigm_h "nn_6n_papper"       ["papper"] $
   (noun_f Neutr ([e ""], [(id,"et"),(dv,"et")], [(id,"")], [e "en", (dv,"en")])),  
  paradigm_h "nn_6n_rum"          ["rum"]  $  nn6_program,
  paradigm_h "nn_6n_träd"         ["träd"] $
   (noun_f Neutr ([e ""], [e "et"], [(tk 1, "n"),(id,"")], [(tk 1, "na"),(id,"en")])),  
  --paradigm_h "nn_6p_ordalag"      ["ordalag"]         nn_6p_ordalag,
  paradigm_h "nn_6u_akademiker"   ["akademiker"]      nn6_akademiker,
  paradigm_h "nn_6u_broder"       ["broder"]          nn_6u_broder,
  paradigm_h "nn_6u_fader"        ["fader"] $
   (noun_f Utr ([e ""], [e "n"], [(vc "ä" . tk 2, "er")],[(vc "ä" . tk 2,"erna")])),  
  paradigm_h "nn_6u_kammare"      ["kammare"] $
   (noun_cf Utr ([e ""], [e "n"], [(tk 4,"rar"),(id,"")], [(tk 4,"rarna")],[(tk 1,"")])),  
  paradigm_h "nn_6u_kikare"       ["kikare"]          nn6_kikare,
  paradigm_h "nn_6u_mus"          ["mus"]             nn_6u_mus,
  paradigm_h "nn_6u_vaktman"      ["vaktman"]         nn_6u_vaktman,
  paradigm_h "nn_6v_borst"        ["borst"]           nn_6v_borst,
  paradigm_h "nn_7u_hit"          ["hit"]             nn_7u_musical,
  paradigm_h "nn_7u_ranger"      ["ranger"] $
   (noun_f Utr ([e ""], [e "n"], [e "s"], [e "sen", e "sarna"])),  
  -- paradigm_h "nn_7u_zombie"       ["zombie"]         
  --  (noun Utr [""] ["n"] ["s"] ["sen"]),  
  --paradigm_h "nn_dn_rasket"       ["rasket"]          nn_dn_brådrasket,
  --paradigm_h "nn_du_vippen"       ["vippen"]          nn_du_kneken,
 -- paradigm_h "nn_gu_februari"     ["februari"]        nn_gu_februari,
  paradigm_h "nn_in_vaj"          ["vaj"]             nn_in_vaj,
  paradigm_h "nn_iu_vank"         ["vank"]            nn_iu_avvaktan,
  --paradigm_h "nn_iu_bror"         ["bror"]            nn_iu_bror,
  paradigm_h "nn_iv_hum"          ["hum"]             nn_iv_hum,
  paradigm_h "nn_on_öga"          ["öga"]             nn_on_öga,
  paradigm_h "nn_ou_officer"      ["officer"]         nn_ou_officer,
  paradigm_h "nn_vn_alfa_abc"     ["a"]               nn_vn_alfa_abc,
  paradigm_h "nn_vn_garn"         ["garn"]            nn_vn_garn,
  paradigm_h "nn_vn_huvud"        ["huvud"]           nn_vn_huvud,
  paradigm_h "nn_vn_kvantum"      ["kvantum"] $
   noun_f Neutr  ([e ""], [e "et", e ""], [(tk 2,"a"),e ""], [(tk 2,"a"),e "umen"]), 
  paradigm_h "nn_vn_neutrum"      ["neutrum"] $
   noun_f Neutr  ([e ""], [(tk 2,"et"), e ""], [(tk 2,"a"),(tk 2, "er")], [(tk 2,"an"), (tk 2,"erna")]), 
  paradigm_h "nn_vn_spektrum"     ["spektrum"]        nn_vn_spektrum,
  paradigm_h "nn_vu_blinker"      ["blinker"]         nn_vu_blinker,
  paradigm_h "nn_vu_cyklamen"     ["cyklamen"] $
   noun_f Utr  ([e ""], [e ""], [(id,""), (tk 2,"er")], [(id,""),(tk 2,"erna")]),   
  paradigm_h "nn_vu_dress"        ["dress"]           nn_vu_dress,
  paradigm_h "nn_vu_hambo"        ["hambo"]           nn_vu_hambo,
  paradigm_h "nn_vu_kaliber"      ["kaliber"]         nn_vu_kaliber,
  paradigm_h "nn_vu_playboy"      ["playboy"]         nn_vu_playboy,
  paradigm_h "nn_vu_trio"         ["trio"]            nn_vu_trio,
  paradigm_h "nn_vv_borr"         ["borr"]            nn_vv_borr,
  paradigm_h "nn_vv_test"         ["test"]            nn_vv_test,
  paradigm_h "nna_iu_dr"          ["dr"] $
   nna Utr ([e ""],[],[],[],[],[],[],[]),
  paradigm_h "nna_iv_nxn"         ["nxn"] $
   nna Pend ([e ""],[],[],[],[],[],[],[]),
  paradigm_h "nna_6u_m"           ["m"] $
   nna Utr ([e ""],[e "s"], [e "en"],[e "ens"], [e ""],[e "s"],[e "en"],[e "ens"]),
  --paradigm_h "nnm_du0_vippen"     ["vippen"]          nnm_du0_vippen,
  --paradigm_h "nnm_gn0_alter_ego"  ["alter ego"]       nnm_gn0_alter_ego,
  --paradigm_h "nnm_gu0_best_man"   ["best man"]        nnm_gu0_best_man,
  --paradigm_h "nnm_iu0_avvaktan"   ["avvaktan"]        nnm_iu0_avvaktan,
  paradigm_h "pm_fph_alice"       ["alice"]           $ pm_f "ph",
  paradigm_h "pm_fph_karin"       ["karin"]           $ pm_f "ph",
  paradigm_h "pm_fph_lisa"        ["lisa"]            $ pm_f "ph",
  paradigm_h "pm_fpm_idun"        ["idun"]            $ pm_f "pm",
  paradigm_h "pm_hph_berg"        ["berg"]            $ pm_h "ph",
  paradigm_h "pm_hph_svensson"    ["svensson"]        $ pm_h "ph",
  paradigm_h "pm_mph_ansgar"      ["ansgar"]          $ pm_m "ph",
  paradigm_h "pm_mph_bo"          ["bo"]              $ pm_m "ph",
  paradigm_h "pm_mph_lars"        ["lars"]            $ 
   set_inhs ["m","ph"] . set_pos "pm" . noun_f Neutr  ([e ""], [e ""], [e "ar"], [e "arna"]),   
  paradigm_h "pm_mph_sture"       ["sture"]           $ 
   set_inhs ["m","ph"] . set_pos "pm" . noun_f Neutr  ([e ""], [e ""], [(dv,"ar")], [(dv,"arna")]),   
  paradigm_h "pm_mpm_oden"        ["oden"]            $ pm_m "pm",
  paradigm_h "pm_nlf_kreml"       ["kreml"]           $ pm_n "lf",
  paradigm_h "pm_nlg_delhi"       ["delhi"]           $ pm_n "lg",
  paradigm_h "pm_nlg_eurasien"    ["eurasien"]        $ pm_n "lg",
  paradigm_h "pm_nlg_göteborg"    ["göteborg"]        $ pm_n "lp",
  paradigm_h "pm_nlp_bender"      ["bender"]          $ pm_n "lp",
  paradigm_h "pm_nlp_sverige"     ["sverige"]         $ pm_n "lp",
  paradigm_h "pm_nog_volvo"       ["volvo"]           $ pm_n "og",
  paradigm_h "pm_nop_centern"     ["centern"]         $ pm_n "op",
  paradigm_h "pm_plg_alperna"     ["alperna"]         $ pm_p "lg",
  paradigm_h "pm_uag_saab"        ["saab"]            $ pm_u "ag",
  paradigm_h "pm_ula_månen"       ["månen"]           $ pm_u "la",
  paradigm_h "pm_ulg_fyris"       ["fyris"]           $ pm_u "lg",
  paradigm_h "pm_uwb_hemsöborna"  ["hemsöborna"]      $ pm_u "wb",
  paradigm_h "pm_uwc_faust"                   ["faust"]           $ pm_u "wc",
  paradigm_h "pm_uwn_aftonbladet"             ["aftonbladet"]     $ pm_u "wn",
  paradigm_h "pm_vlf_globen"                  ["globen"]          $ pm_v "lf",
  paradigm_h "pma_nog_fn"                     ["fn"]                    $ pma_n "og",
  paradigm_h "pma_nop_cuf"                    ["cuf"]                   $ pma_n "op",
  paradigm_h "pmm_h0ph_de_saussure"           ["de saussure"]           $ pmm_h "ph",
  paradigm_h "pmm_m0ph_bo_ek"                 ["bo ek"]                 $ pmm_m "ph",
  paradigm_h "pmm_n0lg_new_delhi"             ["new delhi"]             $ pmm_n "lg",
  paradigm_h "pmm_n0lg_svarta_havet"          ["svarta havet"]          $ pmm_n "lg",
  paradigm_h "pmm_n0lp_sri_lanka"             ["sri lanka"]             $ pmm_n "lp",
  paradigm_h "pmm_n0oe_göteborgs_universitet" ["göteborgs universitet"] $ pmm_n "oe",
  paradigm_h "pmm_n0og_nordiska_rådet"        ["nordiska rådet"]        $ pmm_n "og",
  paradigm_h "pmm_u0lg_torne_älv"             ["torne älv"]             $ pmm_u "lg",
  paradigm_h "pmm_u0wb_det_går_an"            ["Quo vadis?"]            $ pmm_u "wb",
  paradigm_h "pmm_n0wm_ring_p1"               ["Ring P1"]           $ pmm_n "wm",
  paradigm_h "pmm_u0ec_alla_hjärtans_dag"     ["alla hjärtans dag"] $ pmm_u "ec",
  paradigm_h "pmm_u0og_svenska_akademien"     ["Svenska Akademien"] $ pmm_u "og",
  paradigm_h "pn_i_man"                       ["man"]                 pn_inv,
  paradigm_h "pnm_x1_inte_ett_dugg"           ["inte ett dugg"]       pnm_inv,
  paradigm_h "pp_i_i"                         ["i"]                   prep,
  paradigm_h "vb_1a_laga"                     ["laga"]                v1,
  paradigm_h "vb_1s_andas"                    ["andas"]               vb_1s_hoppas,
  paradigm_h "vb_2a_ansöka"                   ["ansöka"] $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "te"], [e "t"], [e "t"]),
  paradigm_h "vb_2a_göra"              ["göra"]                vb_2a_göra,
  paradigm_h "vb_2a_hyra"              ["hyra"] $
   verb_wcf 1 ([e "a"], [e ""], [e ""], [e "de"], [e "t"], [e "d"]),
  paradigm_h "vb_2a_känna"             ["känna"] $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(tk 1, "de")], [(tk 1,"t")], [e "d"]),
  paradigm_h "vb_2a_leda"              ["leda"]  $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "de"], [(tk 1, "tt")], [e "d"]),
  paradigm_h "vb_2a_lägga"             ["lägga"]  $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "a".tk 2,  "de"),(vc "a".tk 2,  "")], [(vc "a" . tk 2, "t")], [(vc "a","d")]),
  paradigm_h "vb_2a_sätta"             ["sätta"] $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [(vc "a", "e")], [(vc "a" , "")], [(vc "a","")]),
  paradigm_h "vb_2a_viga"              ["viga"] $
   verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "de"], [e "t"], [e "d"]),
  paradigm_h "vb_2s_synas"             ["synas"]               vb_2s_synas,
  paradigm_h "vb_4a_falla"             ["falla"]               vb_4a_falla,
  paradigm_h "vb_4a_flyga"             ["flyga"]               vb_4a_supa,
  paradigm_h "vb_4a_ge"                ["ge"] $
   verb_wcf 0 ([e "", (vc "i","va")], [e "r",(vc "i","ver")], [e "",(vc "i","v")], [(vc "a","v")], [e "tt",(vc "i","vit")], [(vc "i", "ven")]),
  paradigm_h "vb_4a_hålla"             ["hålla"]               vb_4a_hålla,
  paradigm_h "vb_4a_komma"             ["komma"]               vb_4a_komma,
  paradigm_h "vb_4a_rida"              ["rida"]                vb_4a_bita,
  paradigm_h "vb_4a_skjuta"            ["skjuta"] $
  (verb_wcf 1 ([e "a"], [e "er"], [e ""], [(tk 3,"öt")], [e "it"], [e "en"])),
  paradigm_h "vb_4a_tillåta"           ["tillåta"]             vb_4a_låta,
  paradigm_h "vb_4a_slå"               ["slå"]                 vb_4a_slå,
  paradigm_h "vb_4a_se"                ["se"]                  vb_4a_se,
  paradigm_h "vb_4a_gå"                ["gå"]                  vb_4a_gå,
  paradigm_h "vb_4a_dricka"            ["dricka"]              vb_4a_vinna,

  paradigm_h "vb_4a_bära"              ["bära"]   $
  (verb_wcf 1 ([e "a"], [e ""], [e ""], [(vc "a","")], [(vc "u", "it")], [(vc "u","en")])),

  paradigm_h "vb_4m_innebära"     ["bära"]   $
   (verb_wcf 1 ([e "a"], [e ""], [e ""], [(vc "a","")], [(vc "u", "it")], [])),

  paradigm_h "vb_4a_ta"                ["ta"]             
  (verb_wcf 0 ([e "",e "ga"], [e "r",e "ger"], [e ""], [(vc "o","g")], [e "git"], [e "gen"])),
  paradigm_h "vb_va_klä"                ["klä"]             
  (verb_wcf 0 ([e "da",e ""], [e "r",e "der"], [e ""], [e "dde"], [e "tt"], [e "dd"])),
  paradigm_h "vb_4m_angå"              ["angå"] 
  (verb_fwcf 0 ([e ""], [],[e "r"],[e ""],[(vc "i","nge")],  [(vc "i","ck")], [e "tt"], [])),
  paradigm_h "vb_4m_stå"               ["stå"]                 vb_4m_stå,
  paradigm_h "vb_4m_vina"              ["vina"]                vb_4m_vina,
  paradigm_h "vb_va_bringa"            ["bringa"]              vb_va_bringa,

  --paradigm_h "nl_o_andra"          ["andra"]   number_andra,
  --paradigm_h "nn_1d_faggorna"  ["faggorna"]  nn1_faggorna,
  paradigm_h "nn_1u_flicka"       ["flicka"]     nn1_flicka,
  --paradigm_h "nn_2p_vägnar"      ["vägnar"]     nn2_vägnar,
  paradigm_h "nn_2u_botten"      ["botten"] $
   noun_f Utr  ([e ""], [(dv,"en"),e ""], [(dv, "ar")], [(dv,"arna")]),   
  paradigm_h "nn_2u_nyckel"       ["nyckel"]     nn2_nyckel,
  paradigm_h "nn_2u_pojke"         ["pojke"]      nn2,
  paradigm_h "nn_2u_stol"            ["stol"]       nn2,
  paradigm_h "nn_4u_linje"           ["linje"]       nn4,
  paradigm_h "nn_5n_knä"            ["knä"]         nn5_knä,
  paradigm_h "nn_6n_garage"       ["garage"]      nn6_garage,
  paradigm_h "nn_6n_segel"         ["segel"] $
   noun_f Neutr  ([e ""], [(dv,"et")], [e ""], [(dv,"en")]),   
  paradigm_h "nn_6u_gås"            ["gås"]            nn_6u_gås,
  --paradigm_h "nn_7p_jeans"         ["jeans"]          nn_7p_jeans,
  paradigm_h "nn_ou_emeritus"    ["emeritus"]       nn_ou_emeritus,
  paradigm_h "nn_ou_examen"     ["examen"]         nn_ou_examen,
  paradigm_h "nn_vn_centrum"     ["centrum"]        nn_vn_centrum,
  paradigm_h "nn_vn_nomen"       ["nomen"]          nn_vn_nomen,
  --paradigm_h "nn_vn_tempo"        ["tempo"]          nn_vn_tempo,
  paradigm_h "nn_vu_jojo"            ["jojo"]       nn_vu_jojo,
  paradigm_h "nn_vu_partner"      ["partner"]        nn_vu_partner,
  paradigm_h "nn_vv_abdomen"   ["abdomen"]       nn_vv_abdomen,
  paradigm_h "vb_2a_lyfta"           ["lyfta"] $
    verb_wcf 1 ([e "a"], [e "er"], [e ""], [e "e"], [e ""], [e ""]),
  paradigm_h "vb_2a_sända"         ["sända"]   vb_2a_sända,
  paradigm_h "vb_3a_sy"               ["sy"]      v3,
  paradigm_h "vb_va_koka"           ["koka"]    vb_va_koka,
  paradigm_h "vb_va_sprida"         ["sprida"]  $
   (verb_wcf 1 ([e "a"],[e "er"],[e ""], [(vc "e",""),e "de"], [(tk 1,"tt"),e "it"], [e "d"])),    
  --paradigm_h "nl_g_tre"     ["tre"]     number_numeral,
  paradigm_h "av_2_ung"          ["ung"]        av_2_ung
 ]

