module Example.Components.Container (component) where

import Prelude

import Control.Monad.State (modify_)
import Data.Maybe (Maybe(..), maybe)
import Debug as D
import Effect (Effect)
import Example.Components.Button as Button
import MUI.Core.Button as MCB
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (JSX)
import React.Halo (HaloM, Lifecycle)
import React.Halo as H
import Type.Proxy (Proxy(..))
import Debug as D

data Action
  = HandleButton Button.Message
  | CheckButtonState

type State =
  { toggleCount :: Int
  , buttonState :: Maybe Boolean
  }


-- Halo:
--   Slots for parent-child communication can be replaced with React Context:
--     parent->child with var
--     child->parent with callback

-- type ChildSlots =
--   ( button :: Button.Slot Unit
--   )

_button :: Proxy "button"
_button = Proxy

-- component :: forall q i o m. H.Component q i o m
component :: forall a. Effect (a -> JSX)
component = do
  myButt <- Button.component

  let
    -- render :: forall m. State -> H.ComponentHTML Action ChildSlots m
    render :: forall props ctx.
              { props :: props
              , context :: ctx
              , state :: State
              , send :: Action -> Effect Unit
              } ->
              JSX
    render {state, send} =
      R.div_
        [ myButt unit -- HH.slot _button unit Button.component unit HandleButton
        , R.p_
            [ R.text ("Button has been toggled " <> show state.toggleCount <> " time(s)") ]
        , R.p_
            [ R.text
                $ "Last time I checked, the button was: "
                    <> (maybe "(not checked yet)" (if _ then "on" else "off") state.buttonState)
                    <> ". "
            , MCB.button
              { color: MCB.color.primary
              , variant: MCB.variant.outlined
              , onClick: handler_ $ send CheckButtonState
              , children: [ R.text "Check now" ]
              }
            ]
        ]

  H.component
    "Button Container"
    { initialState
    , context: const (pure unit)
    , render
    , eval
    }
  where

  eval :: forall props ctx m. Lifecycle props ctx Action -> HaloM props ctx State Action m Unit
  eval = H.mkEval _ { onAction = handleAction }

  initialState :: forall props ctx. props -> ctx -> State
  initialState _ _ =
    { toggleCount: 0
    , buttonState: Nothing
    }


  -- handleAction :: forall o m. Action -> H.HalogenM State Action ChildSlots o m Unit
  handleAction :: forall props ctx m. Action -> H.HaloM props ctx State Action m Unit
  handleAction = case _ of
    HandleButton (Button.Toggled _) -> do
      D.traceM "handle HandleButton"
      modify_ (\st -> st { toggleCount = st.toggleCount + 1 })
    CheckButtonState -> do
      D.traceM "handle CheckButtonState"

      -- buttonState <- request _button unit Button.IsOn -- TODO: convert request to Context
      -- modify_ (_ { buttonState = buttonState })
      pure unit
