module Main (main) where

import General
import Saldo
import Data.List
import CommandsSw
import Dictionary

infl_loop :: IO ()
infl_loop = do
  line <- getLine
  let (paradigm:word:form_) = (words line)
  let form = unwords form_
  let inflection = do_inflection paradigm word form
  print (get_whole_paradigm paradigm word)
  maybe (putStrLn "?") (putStrLn . (intercalate " | ")) inflection
  infl_loop

print_all :: IO ()
print_all = mapM_ (\(paradigm, word', f) -> do
              let word = word'!!0 :: String
              let inflections = get_whole_paradigm paradigm word
              maybe (putStrLn "Paradigm not found") (\infl_table -> do
                putStr "\""
                putStr paradigm
                putStr "\": "
                putStr "["
                mapM_ (\(a, b) -> do
                  putStr "(\""
                  putStr a
                  putStr "\", ["
                  mapM_ (\x -> do
                      putStr "\""
                      putStr x
                      putStr "\", "
                    ) b
                  putStr "]),"
                  ) infl_table
                putStrLn "],"
                ) inflections) commands

main :: IO ()
main = infl_loop