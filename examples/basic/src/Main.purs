module Example.Basic.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Effect.Exception as Exception
import Example.Basic.Button as Button
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

-- TODO: add Halo equivalent of module Halogen.Aff.Util

main :: Effect Unit
main = do
  log "🍝 basic"
  container <- getElementById "demo" =<< (map toNonElementParentNode $ document =<< window)
  app <- Button.component
  case container of
    Nothing -> Exception.throw "Container element not found."
    Just c -> do
      liftEffect $ render (app unit) c
