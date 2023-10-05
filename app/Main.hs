module Main (main) where

import General
import Saldo
import Data.List

infl_loop :: IO ()
infl_loop = do
  line <- getLine
  let inflection = do_inflection (words line)
  maybe (putStrLn "?") (putStrLn . (intercalate " | ") . unStr) inflection
  infl_loop

main :: IO ()
main = infl_loop
