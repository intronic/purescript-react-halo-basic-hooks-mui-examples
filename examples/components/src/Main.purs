module Example.Components.Main where

import Prelude

import Effect (Effect)
import Example.Components.Container as Container
-- import Halogen.Aff as HA
-- import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI Container.component unit body

main :: Effect Unit
main = do
  container <- getElementById "demo" =<< (map toNonElementParentNode $ document =<< window)
  app <- Container.component
  case container of
    Nothing -> Exception.throw "Container element not found."
    Just c -> do
      liftEffect $ render (app unit) c
