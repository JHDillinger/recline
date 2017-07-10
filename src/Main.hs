{-# LANGUAGE OverloadedStrings #-}

module Main where

--main :: IO ()
--main = do
--  putStrLn "hello world"


import Reddit
import Reddit.Types.User

import Data.List
import Data.Ord

-- instance Default RedditOptions where
--     def =  RedditOptions True Nothing Anonymous (Just "recline v0.1.0.0")

custom = RedditOptions True Nothing Anonymous (Just "recline v0.1.0.0")

usersToCheck = ["GallowBoob", "spez"]

main = runRedditWith custom $ do
  infos <- mapM (getUserInfo . Username) usersToCheck
  return $ maximumBy (comparing linkKarma) infos
