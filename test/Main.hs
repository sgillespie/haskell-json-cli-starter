module Main (main) where

import Lib (Result (..), runJson)
import Paths_json_demo (getDataFileName)

import Data.Aeson (Value)
import Data.Aeson qualified as Aeson
import Data.Either (isRight)
import Test.Hspec (describe, hspec, it, shouldBe, shouldSatisfy)

main :: IO ()
main = hspec $ do
  describe "Lib" $ do
    describe "Result" $ do
      it "parses the example input" $ do
        inputFile <- getDataFileName "test/data/example.json"
        result <- Aeson.eitherDecodeFileStrict @Value inputFile

        result `shouldSatisfy` isRight

    describe "runJson" $ do
      it "returns Result{}" $ do
        inputFile <- getDataFileName "test/data/example.json"
        actual <- runJson inputFile
        actual `shouldBe` Result{}

