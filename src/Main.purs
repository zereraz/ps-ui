module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Control.Monad.State.Trans (StateT, evalStateT, execStateT, get, lift, modify, put, runStateT)
import DOM (DOM)
import DOM.Event.EventTarget (EventListener, eventListener)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToDocument, readHTMLElement)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement)
import DOM.Node.Types (Element)
import Text.Smolder.HTML (body, button, div, h1, html)
import Text.Smolder.HTML.Attributes (lang)
import Text.Smolder.Markup (Markup, on, text, (!), (#!))
import Text.Smolder.Renderer.DOM (render)

foreign import addToBody :: forall e. Element -> Eff e Unit

type MyState r = StateT Int (Eff r) Element

incMyVal :: forall e. MyState (console :: CONSOLE, dom :: DOM | e)
incMyVal = do
  modify (_ + 1)
  modify (_ + 1)
  modify (_ + 1)
  x <- get
  elem <- lift $ render' $ doc x
  pure elem

render' :: forall eff. Markup (EventListener (dom :: DOM | eff)) -> Eff (dom :: DOM | eff) Element
render' m = do
  doc ← window >>= document >>= htmlDocumentToDocument >>> pure
  el ← createElement "div" doc
  render el m
  pure el

{-- doc :: forall a e. Markup (a -> Eff (console :: CONSOLE | e) Unit) --}
doc x = div do
          h1 $ text "new view"
          button #! (on "click" (eventListener (\_ -> log ("asd" <> show x)))) $ text "asd"

main :: forall e. Eff (console :: CONSOLE, dom :: DOM | e) Unit
main = do
  view <- evalStateT incMyVal 0
  _ <- addToBody view
  log "ui showed"
