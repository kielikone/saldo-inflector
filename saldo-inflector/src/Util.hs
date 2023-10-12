module Util where

import Data.List
import UTF8
import GHC.IO.Handle
import System.IO

quote :: String -> String
quote s = ('\"':(quot s)) ++ "\""
 where quot        [] = []
       quot ('\"':xs) = '\\':'\"':quot xs
       quot (x:xs)    = x:quot xs

splitWith :: Eq a => a -> [a] -> Maybe ([a],[a])
splitWith a xs = 
    case (span (/=a) xs) of
      (as,(_:bs)) -> return (as,bs)
      _           -> Nothing

splitList :: Eq a => a -> [a] -> [[a]]
splitList a [] = []
-- splitList 

-- | Print to stderr.
prErr :: String -> IO()
prErr s =  hPutStr stderr (encodeUTF8 (s ++ "\n"))
