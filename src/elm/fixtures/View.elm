module Fixtures.View (..) where

import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import Fixtures.Model as FixturesModel
import Update
import Fixtures.Views.Fixture as Fixture


view : Signal.Address Update.Action -> FixturesModel.Model -> Html.Html
view address model =
  div
    []
    [ button
        [ onClick address Update.GenerateFixtures ]
        [ text "create fixtures" ]
    , div
        []
        [ text (toString model.isGenerated) ]
    , div
        []
        (List.map Fixture.view model.fixtures)
    ]
