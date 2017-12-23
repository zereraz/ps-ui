module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Control.Monad.State.Trans (StateT, evalStateT, execStateT, get, lift, modify, put, runStateT)
import Text.Smolder.HTML (body, button, div, h1, html)
import Text.Smolder.HTML.Attributes (lang)
import Text.Smolder.Markup (Markup, text, (!))
import Text.Smolder.Renderer.String (render)

foreign import addToBody :: forall e. String -> Eff e Unit

type MyState r = StateT Int (Eff r) String

incMyVal :: forall e. MyState (console :: CONSOLE | e)
incMyVal = do
  modify (_ + 1)
  modify (_ + 1)
  modify (_ + 1)
  x <- get
  pure $ render $ doc x

doc :: forall e. Int -> Markup e
doc x = div $ do
     h1 $ text $ "Hello there " <> show x
     button $ text "asd"


main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  res <- evalStateT incMyVal 0
  addToBody res
