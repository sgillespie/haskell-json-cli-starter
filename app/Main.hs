module Main where

import Lib (runJson)

import Data.Aeson.Encode.Pretty (encodePretty)
import Data.ByteString.Lazy.Char8 qualified as ByteString
import Options.Applicative (Parser, ParserInfo, (<**>))
import Options.Applicative qualified as Opts

newtype Options = Options {optFile :: FilePath}
  deriving stock (Eq, Ord, Show)

main :: IO ()
main = run =<< Opts.execParser options

run :: Options -> IO ()
run Options {..} = do
  res <- runJson optFile
  ByteString.putStrLn (encodePretty res)

options :: ParserInfo Options
options =
  Opts.info (parser <**> Opts.helper) $
    Opts.fullDesc
      <> Opts.progDesc "A sample JSON CLI applications"
      <> Opts.header "starter"

parser :: Parser Options
parser = Options <$> parseFile

parseFile :: Parser FilePath
parseFile =
  Opts.strArgument $
    Opts.metavar "PATH"
      <> Opts.help "Path to a JSON file"
