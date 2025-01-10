module Conduit.Foreign.Tauri where

import Prelude

import Data.Either (Either(..))
import Effect.Aff (error)
import Effect.Aff.Compat (EffectFnAff)
import Effect.Exception (throw)
import Foreign (Foreign)
import Foreign (readInt)
import Foreign.Object (Object)
import Foreign.Object as FO

-- | Invoke a Tauri command with the given name and arguments.
foreign import invokeTauriCommand
  :: String
  -> FO.Object Foreign
  -> EffectFnAff Foreign

-- | Decodes a Foreign value to an Int, throwing an error if it fails.
unsafeDecodeInt :: Foreign -> Int
unsafeDecodeInt value = case readInt value of
  Right n -> n
  Left err -> throw $ error $ "Expected Int, got: " <> show err

-- | Returns an Int from the "add2" Tauri command.
add2 :: EffectFnAff Int
add2 = do
  result <- invokeTauriCommand "add2" FO.empty
  pure $ unsafeDecodeInt result
