module Main (main) where

import General
import Saldo
import Data.List

infl_loop :: IO ()
infl_loop = do
  line <- getLine
  let (paradigm:word:form_) = (words line)
  let form = unwords form_
  let inflection = do_inflection paradigm word form
  maybe (putStrLn "?") (putStrLn . (intercalate " | ") . unStr) inflection
  infl_loop

main :: IO ()
main = infl_loop
