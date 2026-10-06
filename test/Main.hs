module Main (main) where

import Lib (Result (..), runJson)
import Paths_json_demo (getDataFileName)

import Test.Hspec (describe, hspec, it, shouldBe)

main :: IO ()
main = hspec $ do
  describe "Lib" $ do
    describe "runJson" $ do
      it "returns Result{}" $ do
        exampleJson <- getDataFileName "test/data/example.json"
        res <- runJson exampleJson
        res `shouldBe` Result
