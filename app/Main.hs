-- module Main where

-- import Lib

-- main :: IO ()
-- main = someFunc


{-# LANGUAGE OverloadedStrings #-}

module Main where

-- import Reddit
-- import Reddit.Types.User
--
-- import Data.List
-- import Data.Ord
--
-- -- instance Show a => Show (APIError a)
--
-- custom = RedditOptions True Nothing Anonymous (Just "recline v0.1.0.0")
--
-- usersToCheck = ["GallowBoob", "spez"]
--
-- main = do
--     putStrLn "Find the user with the highest karma!"
--     putStrLn "enter first user"
--     a <- readLn
--     putStrLn "enter second user"
--     b <- readLn
--     let users = [a,b]
--     runRedditWith custom $ do
--             infos <- mapM (getUserInfo . Username) users
--             return $ maximumBy (comparing linkKarma) infos

import           Reddit
import           Reddit.Types.Post

import           Control.Monad
import           Control.Monad.IO.Class
import           Data.Monoid
import qualified Data.Text              as Text
import qualified Data.Text.IO           as Text

custom :: RedditOptions
custom = RedditOptions True Nothing Anonymous (Just "recline v0.1.0.0")


main :: IO (Either (APIError RedditError) ())
main = runRedditWith custom $ do
  Listing _ _ posts <- getPosts
  forM_ posts $ \post ->
    liftIO $ Text.putStrLn $
       "\n[" <> tshow (score post) <> "] " <>
       title post <> " (" <> sshow (subreddit post) <> ")"

tshow :: Integer -> Text.Text
tshow = Text.pack . show

sshow :: SubredditName -> Text.Text
sshow = Text.pack . show
