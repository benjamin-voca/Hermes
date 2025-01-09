module Conduit.Foreign.Tauri where

import Foreign (Foreign)
import Foreign.Object as FO
import Promise (Promise)

-- | Invoke a Tauri command with the given name and arguments.
foreign import invokeTauriCommand
  :: String
  -> -- Command name
  (FO.Object Foreign -> Promise Foreign) -- Function taking arguments and returning a Promise
