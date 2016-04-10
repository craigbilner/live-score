module View (..) where

import Html exposing (div)
import Html.Attributes exposing (class)
import Model
import Update
import Styles
import Fixtures.View as FixturesView
import Table.View as TableView


view : Signal.Address Update.Action -> Model.Model -> Html.Html
view address model =
  div
    [ class "layout" ]
    [ div
        [ class "fixtures" ]
        [ FixturesView.view address model.fixtures ]
    , div
        [ class "table" ]
        [ TableView.view address model.table ]
    ]
