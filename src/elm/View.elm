module View (..) where

import Html exposing (div)
import Html.Attributes exposing (class)
import Model
import Update
import Fixtures.View as FixturesView
import Table.View as TableView


view : Signal.Address Update.Action -> Model.Model -> Html.Html
view address model =
  div
    [ class "layout" ]
    [ div
        [ class "layout_fixtures" ]
        [ FixturesView.view address model.fixtures ]
    , div
        [ class "layout_table" ]
        [ TableView.view address model.table ]
    ]
