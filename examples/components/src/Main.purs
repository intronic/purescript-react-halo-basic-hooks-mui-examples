module Example.Components.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Effect.Exception as Exception
import Example.Components.Container as Container
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)
import Debug as D

-- import Halogen.Aff as HA
-- import Halogen.VDom.Driver (runUI)

-- main :: Effect Unit
-- main = HA.runHalogenAff do
--   body <- HA.awaitBody
--   runUI Container.component unit body

main :: Effect Unit
main = do
  log "🍝 components"
  container <- getElementById "demo" =<< (map toNonElementParentNode $ document =<< window)
  D.traceM container
  log "WTF"
  app <- Container.component
  case container of
    Nothing -> Exception.throw "Container element not found."
    Just c -> do
      liftEffect $ render (app unit) c

