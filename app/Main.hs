{-# LANGUAGE DeriveDataTypeable #-}

module Main where

import System.Console.CmdArgs
import Network.Wai.Handler.Warp (run)

import WOLHook (app)

data Opts = Opts {port :: Int} deriving (Show, Data, Typeable)

opts = Opts {port = 8081 &= help "Port to listen on"}

main :: IO ()
main = do
  args <- cmdArgs opts
  run (port args) app