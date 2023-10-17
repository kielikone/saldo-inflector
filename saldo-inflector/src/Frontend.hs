{-# OPTIONS_GHC -fglasgow-exts #-}

module Frontend where


import qualified Data.Set as Set
import qualified Data.Map as Map
import Dictionary
import Util
import Data.Char
import General
import Control.Monad(when)
import Data.Maybe(isJust)
import UTF8
import Data.List(intersperse)
import Data.List

-- NB: This module has been heavily pruned from what it was back in SALDO 1.0

-- Note that all Functions have default definitions, but 
-- in the common case, you give, at least, definitions for "paradigms"
-- "internDict" and "composition"

type Label = String

type TestInput = (String, Dictionary_Word, Category, Paradigm, [String], [Inherent],String)

tword :: TestInput -> Maybe String
tword ("",_,_,_,_,_,_) = Nothing
tword (s,_,_,_,_,_,_) = Just s

w :: TestInput -> String
w t = case (tword t) of
           Just s -> s
           Nothing -> []

thead :: TestInput -> String
thead (_,s,_,_,_,_,_) = s

tcat :: TestInput -> String
tcat  (_,_,s,_,_,_,_) = s

tpara :: TestInput -> String
tpara (_,_,_,s,_,_,_) = s

tparam :: TestInput -> [String]
tparam (_,_,_,_,xs,_,_) = xs

tinhs :: TestInput -> [String]
tinhs (_,_,_,_,_,xs,_) = xs

tid :: TestInput -> String
tid (_,_,_,_,_,_,s) = s

type PositiveTests = [(TestInput -> Maybe String)]

type NegativeTests = [(TestInput -> Maybe String)]

type Result = Maybe String

message :: TestInput -> String -> Result
message t s = Just $ concat ["# [", s, "]\n   ", quote (w t), " {h:\"", pr (thead t),"\" pos:",pr (tcat t)," param:", prl (tparam t),
                             " is:",pri (tinhs t), " id:", pr (tid t), " p:", pr (tpara t),"}"]
 where pr s = case s of
               [] -> "unknown"
               _  -> s
       pri xs = case xs of
                 [] -> "none"
                 _  -> unwords xs
       prl xs = case xs of
                 [] -> "unknown"
                 _  -> unwords xs

pass :: Maybe String
pass = Nothing

type Encoding = String

type TrPos   = String -> String

type TrInhs  = [String] -> [String]

type TrParam = String -> String

print_paradigm :: String -> [String] -> Set.Set String -> String
print_paradigm name xs@(x:_) set = 
 let vars = concat (intersperse "," (zipWith (++) (Set.toList set) (repeat ":char*"))) in 
  unlines 
   ["paradigm " ++ name ++ 
    if null vars then "" else " [" ++ vars ++ "]",
   " = " ++ (print (transform [] x)),
   " {", (splitLines (intersperse "|" (map (print . (transform [])) (nub xs)))), " };\n"
  ]
 where print [] = []
       print ((s,b):xs)
        | b         = concat [s,if_conc xs,print xs]
        | otherwise = concat ["\"",s,"\"",if_conc xs,print xs]
       if_conc [] = []
       if_conc _  = "+"
       splitLines [] = []
       splitLines xs = case splitAt 6 xs of
                        (ys,[]) -> (" " ++ unwords ys) 
                        (ys,zs) -> (" " ++ unwords ys ++ "\n") ++ splitLines zs
       transform     []  [] = []
       transform (x:xs)  [] = [(reverse (x:xs),False)]
       transform ws  (x:xs) = case [z | z <- reverse (inits (x:xs)), 
				        Set.member z set] of
			       (y:_) | null ws -> (y,True):
					       transform [] (drop (length y) (x:xs))
			       (y:_) -> (reverse ws,False):(y,True): 
			                       transform [] (drop (length y) (x:xs))
			       _     -> transform (x:ws) xs

class App a where
    app :: a -> [String] -> Entry
    arity :: a -> Int

instance App Entry where
    app e [] = e
    app e xs = error $ "Too many arguments, got " ++ show (length xs) ++ " wanted 0"
    arity _  = 0

instance App a => App (String -> a) where
 app f ys@(x:xs) | length ys == arity f = app (f x) (xs)
                 | otherwise = error $ "Wrong number of arguments, got " ++ show (length ys) ++ " wanted " ++ show (arity f) ++ " in arguments: '" ++ (unwords ys) ++ "'"
 arity f = 1 + arity (f undefined)

-- paradigm ::  String -> (String, [String], [String] -> Entry) 
paradigm :: (App a) => String -> [String] -> a -> (String, [String], [String] -> Dictionary.Entry)
paradigm id exs f = (id, exs, set_paradigm_id id . app f)

paradigm_h :: (App a) => String -> [String] -> a -> (String, [String], [String] -> Dictionary.Entry)
paradigm_h id exs f = (id, exs, \xs -> case xs of 
                                         []     -> set_paradigm_id id $ app f xs
                                         (x:xs) -> set_head x $ set_paradigm_id id $ app f (x:xs))

-- paradigm_id :: (App a) => String -> [String] -> String -> a -> (String, [String], [String] -> Dictionary.Entry)
-- paradigm_id id exs p f = (id, exs, set_paradigm_id p . (app f))