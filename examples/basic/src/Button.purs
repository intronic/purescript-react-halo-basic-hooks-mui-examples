module Example.Basic.Button (component) where

import Prelude

import Control.Monad.State (modify_)
import Effect (Effect)
import MUI.Core.Button as MCB
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (JSX)
import React.Halo (HaloM, Lifecycle)
import React.Halo as H

type State = { enabled :: Boolean }

data Action = Toggle

component :: forall a. Effect (a -> JSX)
component =
  H.component
    "button"
    { initialState
    , context: const (pure unit)
    , render
    , eval
    }

eval :: forall props ctx m. Lifecycle props ctx Action -> HaloM props ctx State Action m Unit
eval = H.mkEval _ { onAction = handleAction }

initialState :: forall props ctx. props -> ctx -> State
initialState _ _ = { enabled: false }

render :: forall props ctx.
          { props :: props
          , context :: ctx
          , state :: State
          , send :: Action -> Effect Unit
          } ->
          JSX
render {state, send} =
  let
    label = if state.enabled then "On" else "Off"
  in
    -- R.button
    --   { title: label
    --   , onClick: handler_ $ send Toggle
    --   , children: [ R.text label ]
    --   }
    MCB.button
      { title: label
      , color: MCB.color.primary
      , variant: MCB.variant.contained
      , onClick: handler_ $ send Toggle
      , children: [ R.text label ]
      }

handleAction :: forall props ctx m. Action -> H.HaloM props ctx State Action m Unit
handleAction = case _ of
  Toggle ->
    modify_ \st -> st { enabled = not st.enabled }
