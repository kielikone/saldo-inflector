module Main (main) where

import GenRulesSw

main :: IO ()
main = do
  x <- getLine
  print (GenRulesSw.find_stem_vowel x)
