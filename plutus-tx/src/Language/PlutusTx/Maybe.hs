{-# OPTIONS_GHC -fno-omit-interface-pragmas #-}
module Language.PlutusTx.Maybe (isJust, isNothing, maybe, fromMaybe, mapMaybe) where

import           Language.PlutusTx.List
import           Prelude                hiding (foldr, maybe)

{-# ANN module ("HLint: ignore"::String) #-}

{-# NOINLINE isJust #-}
-- | Check if a 'Maybe' @a@ is @Just a@
--
--   >>> isJust Nothing
--   False
--   >>> isJust (Just "plutus")
--   True
--
isJust :: Maybe a -> Bool
isJust m = case m of { Just _ -> True; _ -> False; }

{-# NOINLINE isNothing #-}
-- | Check if a 'Maybe' @a@ is @Nothing@
--
--   >>> isNothing Nothing
--   True
--   >>> isNothing (Just "plutus")
--   False
--
isNothing :: Maybe a -> Bool
isNothing m = case m of { Just _ -> False; _ -> True; }

{-# NOINLINE maybe #-}
-- | PlutusTx version of 'Prelude.maybe'.
--
--   >>> maybe "platypus" (\s -> s) (Just "plutus")
--   "plutus"
--   >>> maybe "platypus" (\s -> s) Nothing
--   "platypus"
--
maybe :: b -> (a -> b) -> Maybe a -> b
maybe b f m = case m of
    Nothing -> b
    Just a  -> f a

{-# NOINLINE fromMaybe #-}
-- | PlutusTx version of 'Data.Maybe.fromMaybe'
fromMaybe :: a -> Maybe a -> a
fromMaybe a = maybe a id

{-# NOINLINE mapMaybe #-}
-- | PlutusTx version of 'Data.Maybe.mapMaybe'.
--
--   >>> mapMaybe (\i -> if i == 2 then Just '2' else Nothing) [1, 2, 3, 4]
--   "2"
--
mapMaybe :: (a -> Maybe b) -> [a] -> [b]
mapMaybe p = foldr (\e xs -> case p e of { Just e' -> e':xs; Nothing -> xs}) []