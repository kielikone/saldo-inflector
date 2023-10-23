{-# LANGUAGE ForeignFunctionInterface #-}

module Saldo (get_whole_paradigm) where

import CommandsSw
import Dictionary
import General

import Text.Read
import Control.Monad
import GHC.Word

import Foreign.C.String
import Foreign.Ptr
import Foreign.Storable
import Foreign.Marshal.Array
import Foreign.Marshal.Alloc


lookup3 :: Eq a => a -> [(a, b, c)] -> Maybe (b, c)
lookup3 key [] = Nothing
lookup3 key ((key2, b, c):rest) = if key == key2 then Just (b, c) else lookup3 key rest

fish_entry_inflections :: Entry -> Inflection_Table
fish_entry_inflections (_, _, _, _, _, x, _) = x

prune_inflection_table :: Inflection_Table -> [(String, [String])]
prune_inflection_table t = [(name, unStr form) | (name, (_, form)) <- t]

get_whole_paradigm :: String -> String -> Maybe [(String, [String])]
get_whole_paradigm paradigm word = do
      (_, f) <- lookup3 paradigm commands :: Maybe ([String], [String] -> Entry)
      let entry = f [word] :: Entry
      let result = prune_inflection_table (fish_entry_inflections entry)
      return result

-- The data structure here is somewhat hairy
-- We do everything with return args
-- void paradigm(char* paradigm_name, char* word, -- Incoming args
--               int* form_name_qty,     // How many forms are we sending over (or -1 on failure)
--               char*** form_names, // What are the names of the forms (length = form_num)
--               int** forms_qty,  // How many forms do we have for each name (length = form_num)
--               char*** inflected_forms // List of all the forms (length = sum(form_num))
-- )
-- If form_names stays NULL, no data structures got allocated or need to be freed.
-- Otherwise every data structure got allocated and needs to be freed
-- The allocated data structures are form_names, forms_qty and inflected_forms

paradigm :: CString -> CString -> (Ptr Word64) -> (Ptr (Ptr CString)) -> (Ptr (Ptr Word64)) -> (Ptr (Ptr CString)) -> IO ()
paradigm paradigm_name_ word_ form_name_qty form_names forms_qty inflected_forms = do
    paradigm_name <- peekCString paradigm_name_
    word <- peekCString word_
    let haskell_result = get_whole_paradigm paradigm_name word
    maybe (return ()) (\table -> do

            -- Send over list of form names

            poke form_name_qty (fromIntegral (length table))
            let form_names_list = [x | (x, _) <- table]
            arr1 <- ((forM form_names_list newCString) >>= newArray)
            poke form_names arr1

            -- Send over list of forms & lengths

            let inflected_forms_list = concat [y | (_, y) <- table] :: [String]
            let forms_qty_list = map (fromIntegral . length) [y | (_, y) <- table] :: [Word64]
            arr2 <- (newArray forms_qty_list)
            poke forms_qty arr2
            arr3 <- ((forM inflected_forms_list newCString) >>= newArray)
            poke inflected_forms arr3
        ) haskell_result

foreign export ccall paradigm :: CString -> CString -> (Ptr Word64) -> (Ptr (Ptr CString)) -> (Ptr (Ptr Word64)) -> (Ptr (Ptr CString)) -> IO ()

-- Frees the array (incl. strings) returned by infl

free_arr :: (Ptr CString) -> Word64 -> IO ()
free_arr arr len = do
    tmp_arr <- peekArray (fromIntegral len) arr
    forM_ tmp_arr free
    free arr

foreign export ccall free_arr :: (Ptr CString) -> Word64 -> IO ()

-- Frees the array (incl. strings) returned by infl

free_int_arr :: (Ptr Word64) -> IO ()
free_int_arr = free

foreign export ccall free_int_arr :: (Ptr Word64) -> IO ()
