{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module WOLHook (app) where

import Control.Monad.IO.Class (liftIO)
import Data.Proxy
import Network.MacAddress (MacAddress, parse)
import Network.WoL (send)
import Servant

import Debug.Trace

type API = "wol" :> Capture "mac" String :> Post '[PlainText] String

app :: Application
app = serve wolHookProxy wolHookServer

wolHookProxy :: Proxy API
wolHookProxy = Proxy

wolHookServer :: Server API
wolHookServer = wol

wol :: String -> Handler String
wol macStr = do
  let mac = parse macStr
  let broadcast = maxBound
  let discard = 9
  liftIO $ send broadcast mac discard
  return $ "Sending magic packet for " ++ (show mac)