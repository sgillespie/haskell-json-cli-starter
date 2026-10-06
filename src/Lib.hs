module Lib
  ( Result (..),
    runJson,
  ) where

import Control.Exception (throwIO)
import Data.Aeson (FromJSON, ToJSON, Value)
import Data.Aeson qualified as Aeson
import GHC.Generics (Generic)

data Result = Result
  deriving stock (Eq, Generic, Ord, Show)
  deriving anyclass (FromJSON, ToJSON)

runJson :: FilePath -> IO Result
runJson inFile = do
  _ <- parseJsonFile @Value inFile
  pure Result

-- | Parse the provided file. If it fails, throw the error in IO
parseJsonFile :: (FromJSON a) => FilePath -> IO a
parseJsonFile inFile = do
  parseResult <- Aeson.eitherDecodeFileStrict inFile
  either
    (throwIO . userError)
    pure
    parseResult
