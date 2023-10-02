module Main (main) where

import GenRulesSw

main :: IO ()
main = do
  x <- getLine
  printLn (GenRulesSw.get_stem_vowel x)
