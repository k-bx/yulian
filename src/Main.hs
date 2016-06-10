module Main where

import qualified Data.Map as M
import Lexer (tokenize)
import Parser (parse)
import Evaluator (evaluate)
import System.Environment (getArgs)


main :: IO ()
main = do
  args <- getArgs
  src <- readFile $ show $ head args--"base.asm"
  let strokes = lines src
  loop (M.fromList [("pi", pi)]) strokes

loop symTab [] = putStrLn "Finished reading"
loop symTab (strokesHead:strokesTail) = do
    let toks = tokenize strokesHead
    let tree = parse toks
    let (val, symTab') = evaluate tree symTab
    -- print tree
    --print toks
    loop symTab' strokesTail
