module Conduit.Foreign.Tauri where

import Control.Promise (Promise, toAffE)
import Effect (Effect)
import Effect.Aff (Aff)

-- foreign import data Response :: Type
{-foreign import invoke_
:: forall a
 . String
-> Foreign
-> EffectFnAff a-}
foreign import invoke_ :: forall r o a. String -> { | r } -> { | o } -> Effect (Promise a)

invokeAff :: forall r o a. String -> { | r } -> { | o } -> Aff a
invokeAff cmd args opts = toAffE (invoke_ cmd args opts)

-- invoke :: String -> Object Foreign -> Aff Foreign
-- invoke cmd args = toAffE $ invoke_ cmd args

-- invoke_
{-
invoke
  :: forall a
   . String
  -> Object.Object Foreign
  -> Object.Object Foreign
  -> Aff a
invoke cmd args options = do
  liftEffect $ do
    promise <- invoke_ cmd (unsafeCoerce args) (unsafeCoerce options)
    unsafeCoerce promise
-}
greet :: String -> Aff String
greet name = invokeAff "greet" { name: name } {}
