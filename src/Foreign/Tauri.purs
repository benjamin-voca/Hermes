module Conduit.Foreign.Tauri where

import Data.Either (Either)
import Effect.Aff (Aff)
import Foreign (Foreign)
import Foreign.Object as FO

-- | Invoke a Tauri command with the given name and arguments.
foreign import invokeTauriCommand
  :: String
  -> FO.Object Foreign
  -> Aff (Either String Foreign) -- Aff to handle async effects with error handling
