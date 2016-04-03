module View (..) where

import Html exposing (div, text)
import Html.Attributes exposing (style)
import Model
import Update
import Styles
import Fixtures.View as FixturesView
import Table.View as TableView


view : Signal.Address Update.Action -> Model.Model -> Html.Html
view address model =
  div
    [ style Styles.layout ]
    [ div
        [ style Styles.fixtures ]
        [ FixturesView.view address model.fixtures ]
    , div
        [ style Styles.table ]
        [ TableView.view address model.table ]
    ]
