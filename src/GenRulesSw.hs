----------------------------------------------------------------------
-- |
-- Module      : GenRulesSw
-- Maintainer  : Markus Forsberg
-- Stability   : (stability)
-- Portability : (portability)
--
--
-- General functions for Swedish
-------------------------------------------------------------------------
module GenRulesSw (
		   e, apply_suffixes, Suffixes,
                   dv, keep,dsuff,
                   drop_last_vowel,
                   -- drop_last_vowel,
                    lift,
                    is_vowel,
                    is_voiced,
                    if_vowel,
                    drop_final_e,
                    ungeminate,
                    ungeminate_m_n,
                    drop_second_last,
                    insert_second_last,
                    geminate,
                    find_stem_vowel,
                    vc,vct,
                    dpl,
                    mmn,
                    umlaut
                  ) where

import General
import Data.List

type Suffixes = [((String -> String), String)]

e :: String -> ((String -> String),String)
e s = (id,s) 

apply_suffixes :: String -> Suffixes -> [String]
apply_suffixes stem xs = [f stem ++ suff | (f,suff) <- xs]

lift :: [a] -> [[a]]
lift  [] = []
lift   s = [s]

keep :: Int -> (String -> String) -> String -> String
keep n f s = f pre ++ suf
 where
  (pre,suf) = case splitAt n (reverse s) of
               (rs,rp) -> (reverse rp, reverse rs)

drop_last_vowel = dv

dsuff :: String -> String -> String
dsuff suff s 
 | isPrefixOf (reverse suff) (reverse s) = tk (length suff) s
 | otherwise = s

dv :: String -> String
dv w = case find_stem_vowel w of
        (seg,e,l) -> seg ++ l

dpl :: Char -> String -> String
dpl c s = case span (/= c) (reverse s) of
           (b,_:r) -> reverse (b ++ r)
           (b,[])  -> reverse b

drop_second_last :: String -> String
drop_second_last s = (tk 2 s) ++ (dp 1 s)

is_vowel :: Char -> Bool
is_vowel c = elem c "aeiouyåäö"

is_voiced :: Char -> Bool
is_voiced c = elem c "bdglmnrvj"

if_vowel :: Char -> String -> String -> String
if_vowel c d e = if is_vowel c then d else e

drop_final_e :: String -> String
drop_final_e = dropEndIf (=='e')

insert_second_last :: String -> Char -> String
insert_second_last s c = init s ++ [c] ++ [last s]

geminate :: String -> String
geminate s = s ++ dp 1 s

ungeminate :: String -> String
ungeminate s = case reverse s of
  'm':'m':_ -> init s
  _         -> s

ungeminate_m_n :: String -> String
ungeminate_m_n s = case reverse s of
  n:m:_ | n == m && elem n "nm" -> init s
  _ -> s

mmn :: String -> String
mmn s = case reverse s of
         ('n':'m':'m':xs)  -> (reverse ('n':'m':xs))
         _                 -> s

--3 Umlaut
--
-- Let's conclude with something that is not easy to do on this level of generality
-- with regular expressions: 
-- define first the *stem vowel* as the last vowel (or diphtong) in the stem:

find_stem_vowel :: String -> (String, String, String)
find_stem_vowel sprick = (reverse rps, reverse i, reverse kc) where
  (kc, irps) = break is_vowel $ reverse sprick
  (i,   rps) = span  is_vowel $ irps

-- vowel change
vc :: String -> String -> String
vc v sprick = 
  case find_stem_vowel sprick of
    (spr,i,ck) -> spr ++ v ++ ck

vct :: [(String,String)] -> String -> String
vct xs sprick =   case find_stem_vowel sprick of
                    (spr,i,ck) -> spr ++ (v i) ++ ck
 where v i = case lookup i xs of
               Just x -> x
               Nothing -> i

-- Although *umlaut* is not very very useful in Swedish, we are glad to
-- present a general rule for it:

umlaut :: String -> String
umlaut man = m ++ mkUm a ++ n where
  (m,a,n) = find_stem_vowel man
  mkUm v = case v of
    "a" -> "ä"
    "o" -> "ö"
    "å" -> "ä"
    "u" -> "y"
    _   -> v
