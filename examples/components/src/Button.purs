-- module Example.Components.Button (Slot, Query(..), Message(..), component) where
module Example.Components.Button (Query(..), Message(..), component) where

import Prelude

import Control.Monad.State (modify, get)
import Data.Maybe (Maybe(..))
import Debug as D
import Effect (Effect)
import MUI.Core.Button as MCB
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (JSX)
import React.Halo (HaloM, Lifecycle)
import React.Halo as H

-- import Halogen.HTML as HH
-- import Halogen.HTML.Events as HE
-- import Halogen.HTML.Properties as HP

-- type Slot = H.Slot Query Message

data Query a = IsOn (Boolean -> a)

data Message = Toggled Boolean

data Action = Toggle

type State = { enabled :: Boolean }

-- component :: forall i m. H.Component Query i Message m
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
eval =
  H.mkEval
    _
      { onAction = handleAction
      , onUpdate = handleUpdate -- when props or context change we might need to raise an Action
      -- , handleQuery = handleQuery
      }

-- initialState :: forall i. i -> State
initialState :: forall props ctx. props -> ctx -> State
initialState _ _ = { enabled: false }

render :: forall props ctx.
          { props :: props
          , context :: ctx
          , state :: State
          , send :: Action -> Effect Unit
          } ->
          JSX
-- render :: forall m. State -> H.ComponentHTML Action () m
render {state, send} =
  let
    label = if state.enabled then "On" else "Off"
  in
    MCB.button
      { title: label
      , color: MCB.color.primary
      , variant: MCB.variant.contained
      , onClick: handler_ $ send Toggle
      , children: [ R.text label ]
      }

-- handleAction :: forall m. Action -> H.HalogenM State Action () Message m Unit
handleAction :: forall props ctx m. Action -> H.HaloM props ctx State Action m Unit
handleAction = case _ of
  Toggle -> do
    {enabled} <- get
    newState <- modify \st -> st { enabled = not st.enabled }
    D.traceM $ "Button Action: Toggle " <> show enabled <> " -> " <> show newState.enabled
    pure unit -- TODO: set context
    -- H.raise (Toggled newState.enabled)


handleUpdate :: forall props ctx. { props :: props, context :: ctx } -> { props :: props, context :: ctx } -> Maybe Action
handleUpdate old new = do
  D.traceM $ "Button Update"
  Nothing -- :: Maybe Action

-- TODO: get context
-- handleQuery :: forall m a. Query a -> H.HalogenM State Action () Message m (Maybe a)
-- handleQuery = case _ of
--   IsOn k -> do
--     enabled <- H.gets _.enabled
--     pure (Just (k enabled))
