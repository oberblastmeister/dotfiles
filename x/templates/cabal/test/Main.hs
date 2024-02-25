module Main (main) where

import Cp qualified
import Data.Function ((&))
import System.FilePath
import System.Process.Typed qualified as Process
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
  testGroup
    "tests"
    [
    ]

