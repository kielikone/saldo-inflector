{-# LANGUAGE ForeignFunctionInterface #-}

module Saldo (do_inflection) where

import GenRulesSw
import VerbRulesSw
import NounRulesSw
import AdjRulesSw
import TypesSw
import General

import Text.Read
import Control.Monad

import Foreign.C.String
import Foreign.Ptr
import Foreign.Storable
import Foreign.Marshal.Array
import Foreign.Marshal.Alloc

vb_lookup :: [(String, String -> Verb)]
vb_lookup = [("vb1", vb1),
             ("vb2", vb2),
             ("vb2följa", vb2följa),
             ("vb2sända", vb2sända),
             ("vb2knäcka", vb2knäcka),
             ("vb2vända", vb2vända),
             ("vb2dröja", vb2dröja),
             ("vb2göra", vb2göra),
             ("vb3", vb3),
             ("vb3klä", vb3klä),
             ("vb4krypa", vb4krypa),
             ("vb4vinna", vb4vinna),
             ("vb4falla", vb4falla),
             ("vb4bita", vb4bita),
             ("vb4slå", vb4slå),
             ("vb4vina", vb4vina),
             ("vb4supa", vb4supa),
             ("vb4komma", vb4komma),
             ("vb4fara", vb4fara),
             ("vb4låta", vb4låta),
             ("vb4äta", vb4äta),
             ("vb4hålla", vb4hålla),
             ("vb4giva", vb4giva),
             ("vb4bliva", vb4bliva),
             ("vb4draga", vb4draga),
             ("vb4taga", vb4taga),
             ("vb4binda", vb4binda),
             ("vb4se", vb4se),
             ("vb4gå", vb4gå),
             ("vb4göra", vb4göra),
             ("vb4stå", vb4stå),
             ("vb4få", vb4få),
             ("vb4hava", vb4hava),
             ("vb4vara", vb4vara),
             ("vbdsynas", vbdsynas),
             ("vbdlyckas", vbdlyckas),
             ("vbdhoppas", vbdhoppas),
             ("vbdnalkas", vbdnalkas),
             ("vbdfärdas", vbdfärdas),
             ("vbdvederfås", vbdvederfås),
             ("vbvkoka", vbvkoka),
             ("vbvmista", vbvmista),
             ("vbvbringa", vbvbringa),
             ("vbvtala", vbvtala)]

nn_lookup :: [(String, String -> Substantive)]
nn_lookup = [("nn1", nn1),
             ("nn1flicka", nn1flicka),
             ("nn1kyrka", nn1kyrka),
             ("nn1gata", nn1gata),
             ("nn1olja", nn1olja),
             ("nn1mamma", nn1mamma),
             ("nn1siffra", nn1siffra),
             ("nn1dimma", nn1dimma),
             ("nn1sopor", nn1sopor),
             ("nn1faggorna", nn1faggorna),
             ("nn2", nn2),
             ("nn2nyckel", nn2nyckel),
             ("nn2öken", nn2öken),
             ("nn2hummer", nn2hummer),
             ("nn2kam", nn2kam),
             ("nn2pengar", nn2pengar),
             ("nn2mor", nn2mor),
             ("nn2dotter", nn2dotter),
             ("nn2fordran", nn2fordran),
             ("nn2verkan", nn2verkan),
             ("nn2toker", nn2toker),
             ("nn2herre", nn2herre),
             ("nn2vers", nn2vers),
             ("nn2manöver", nn2manöver),
             ("nn2själ", nn2själ),
             ("nn2brud", nn2brud),
             ("nn2jord", nn2jord),
             ("nn2hjälte", nn2hjälte),
             ("nn2herde", nn2herde),
             ("nn2by", nn2by),
             ("nn2fågel", nn2fågel),
             ("nn2lem", nn2lem),
             ("nn2vägnar", nn2vägnar),
             ("nn2stadgar", nn2stadgar),
             ("nn3", nn3),
             ("nn3vin", nn3vin),
             ("nn3gäst", nn3gäst),
             ("nn3bygd", nn3bygd),
             ("nn3hävd", nn3hävd),
             ("nn3motor", nn3motor),
             ("nn3parti", nn3parti),
             ("nn3poesi", nn3poesi),
             ("nn3musa", nn3musa),
             ("nn3museum", nn3museum),
             ("nn3gladiolus", nn3gladiolus),
             ("nn3fiber", nn3fiber),
             ("nn3tand", nn3tand),
             ("nn3land", nn3land),
             ("nn3paraply", nn3paraply),
             ("nn3hobby", nn3hobby),
             ("nn3kastanj", nn3kastanj),
             ("nn3akademi", nn3akademi),
             ("nn3paket", nn3paket),
             ("nn3element", nn3element),
             ("nn3kläder", nn3kläder),
             ("nn3kliche", nn3kliche),
             ("nn3bok", nn3bok),
             ("nn3fot", nn3fot),
             ("nn3vän", nn3vän),
             ("nn3flanell", nn3flanell),
             ("nn4", nn4),
             ("nn4studio", nn4studio),
             ("nn4ampere", nn4ampere),
             ("nn4bonde", nn4bonde),
             ("nn5", nn5),
             ("nn5knä", nn5knä),
             ("nn5äpple", nn5äpple),
             ("nn5samhälle", nn5samhälle),
             ("nn5arbete", nn5arbete),
             ("nn5bi", nn5bi),
             ("nn5frö", nn5frö),
             ("nn5party", nn5party),
             ("nn5abc", nn5abc),
             ("nnkol14", nnkol14),
             ("nn5anmodan", nn5anmodan),
             ("nn6", nn6),
             ("nn6barn", nn6barn),
             ("nn6arv", nn6arv),
             ("nn6mil", nn6mil),
             ("nn6broder", nn6broder),
             ("nn6akademiker", nn6akademiker),
             ("nn6lager", nn6lager),
             ("nn6nummer", nn6nummer),
             ("nn6garage", nn6garage),
             ("nn6manus", nn6manus),
             ("nn6gås", nn6gås),
             ("nn6ordförande", nn6ordförande),
             ("nn6far", nn6far),
             ("nn6papper", nn6papper),
             ("nn6kikare", nn6kikare),
             ("nn6program", nn6program),
             ("nn6mus", nn6mus),
             ("nn6vaktman", nn6vaktman),
             ("nn6borst", nn6borst),
             ("nn6klientel", nn6klientel),
             ("nn6frx", nn6frx),
             ("nn6ordalag", nn6ordalag),
             ("nn7musical", nn7musical),
             ("nn0", nn0),
             ("nn0oväsen", nn0oväsen),
             ("nn0tröst", nn0tröst),
             ("nn0adel", nn0adel),
             ("nn0skum", nn0skum),
             ("nn0skam", nn0skam),
             ("nn0manna", nn0manna),
             ("nn0början", nn0början),
             ("nn0uran", nn0uran),
             ("nn0biologi", nn0biologi),
             ("nn0brådska", nn0brådska),
             ("nn0smör", nn0smör),
             ("nn0kaffe", nn0kaffe),
             ("nn0socker", nn0socker),
             ("nn0januari", nn0januari),
             ("nn0aktinium", nn0aktinium),
             ("nnvkansli", nnvkansli),
             ("nnvfaktum", nnvfaktum),
             ("nnvdistikon", nnvdistikon),
             ("nnvabdomen", nnvabdomen),
             ("nnvnomen", nnvnomen),
             ("nnvunderstatement", nnvunderstatement),
             ("nnvfranc", nnvfranc),
             ("nnvcocktail", nnvcocktail),
             ("nnvgangster", nnvgangster),
             ("nnvpartner", nnvpartner),
             ("nnvcentrum", nnvcentrum),
             ("nnvtempo", nnvtempo),
             ("nnvantecedentia", nnvantecedentia),
             ("nnvtrall", nnvtrall),
             ("nnvbehå", nnvbehå),
             ("nnvjojo", nnvjojo),
             ("nnvsandwich", nnvsandwich),
             ("nnvabc", nnvabc),
             ("nnvgarn", nnvgarn),
             ("nnvhuvud", nnvhuvud),
             ("nnvkvantum", nnvkvantum),
             ("nnvspektrum", nnvspektrum),
             ("nnvblinker", nnvblinker),
             ("nnvdress", nnvdress),
             ("nnvhambo", nnvhambo),
             ("nnvkaliber", nnvkaliber),
             ("nnvklammer", nnvklammer),
             ("nnvplayboy", nnvplayboy),
             ("nnvroller", nnvroller),
             ("nnvtrio", nnvtrio),
             ("nnvborr", nnvborr),
             ("nnvtest", nnvtest),
             ("nnonarkotikum", nnonarkotikum),
             ("nnoexamen", nnoexamen),
             ("nnoemeritus", nnoemeritus),
             ("nnofullmäktig", nnofullmäktig),
             ("nnoöga", nnoöga),
             ("nnodata", nnodata),
             ("nnoofficer", nnoofficer),
             ("nndkneken", nndkneken),
             ("nndbrådrasket", nndbrådrasket),
             ("nni", nni),
             ("nngfebruari", nngfebruari)]

av_lookup :: [(String, String -> Adjective)]
av_lookup = [("av0kronisk", av0kronisk),
             ("av0konstlad", av0konstlad),
             ("av0gängse", av0gängse),
             ("av0lastgammal", av0lastgammal),
             ("av0medelstor", av0medelstor),
             ("av1blek", av1blek),
             ("av1fri", av1fri),
             ("av1lätt", av1lätt),
             ("av1glad", av1glad),
             ("av1högljudd", av1högljudd),
             ("av1hård", av1hård),
             ("av1tunn", av1tunn),
             ("av1ensam", av1ensam),
             ("av1vacker", av1vacker),
             ("av1angelägen", av1angelägen),
             ("av1ringa", av1ringa),
             ("av1akut", av1akut),
             ("av1lat", av1lat),
             ("av2ung", av2ung),
             ("av2yttre", av2yttre)]

usage :: String
usage = "USAGE: Interactive, lines of the form \"fn word form\""

do_verb :: [String] -> Maybe Str
do_verb (fn_name:word:rest) = as_verb_maybe >>= (\verb -> form_maybe >>= (\form -> Just (verb form)))
    where fn_maybe = lookup fn_name vb_lookup :: Maybe (String -> Verb)
          as_verb_maybe = fn_maybe >>= (\fn -> Just (fn word)) :: Maybe Verb
          form_maybe = readMaybe (unwords rest) :: Maybe VerbForm
do_verb _ = Nothing


do_noun :: [String] -> Maybe Str
do_noun (fn_name:word:rest) = as_noun_maybe >>= (\noun -> form_maybe >>= (\form -> Just (noun form)))
    where fn_maybe = lookup fn_name nn_lookup :: Maybe (String -> Substantive)
          as_noun_maybe = fn_maybe >>= (\fn -> Just (fn word)) :: Maybe Substantive
          form_maybe = readMaybe (unwords rest) :: Maybe SubstForm
do_noun _ = Nothing


do_adjective :: [String] -> Maybe Str
do_adjective (fn_name:word:rest) = as_adjective_maybe >>= (\adjective -> form_maybe >>= (\form -> Just (adjective form)))
    where fn_maybe = lookup fn_name av_lookup :: Maybe (String -> Adjective)
          as_adjective_maybe = fn_maybe >>= (\fn -> Just (fn word)) :: Maybe Adjective
          form_maybe = readMaybe (unwords rest) :: Maybe AdjForm
do_adjective _ = Nothing

firstJusts :: [Maybe a] -> Maybe a
firstJusts [] = Nothing
firstJusts (Just x:_) = Just x
firstJusts (Nothing:tail) = firstJusts tail

do_inflection :: [String] -> Maybe Str
do_inflection words = firstJusts [(do_verb words), (do_noun words), (do_adjective words)]


-- Caller allocates input string and is responsible for calling free_arr
-- Callee allocates and populates output array
-- Caller is responsible for calling deallocator provided by callee iff returned array is not null
-- Num of elements in returned array is written to the given pointer (undefined if returned array is null)

-- Output can be nullptr: this happens if the input failed to parse

infl :: CString -> (Ptr Int) -> IO (Ptr CString)
infl line ret_val = do
    input <- peekCString line
    let haskell_result = fmap unStr (do_inflection (words input))
    maybe (return nullPtr) (\strings -> do
        poke ret_val (length strings)
        (forM strings newCString) >>= newArray) haskell_result

foreign export ccall infl :: CString -> (Ptr Int) -> IO (Ptr CString)

-- Frees the array (incl. strings) returned by infl

free_arr :: (Ptr CString) -> Int -> IO ()
free_arr arr len = do
    tmp_arr <- peekArray len arr
    forM_ tmp_arr free
    free arr

foreign export ccall free_arr :: (Ptr CString) -> Int -> IO ()