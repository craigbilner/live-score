module Fixtures.View (..) where

import Html exposing (div, button, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Fixtures.Model as FixturesModel
import Update
import Fixtures.Views.Fixture as Fixture


view : Signal.Address Update.Action -> FixturesModel.Model -> Html.Html
view address model =
  div
    []
    [ div
        [ class "fixtures_buttons" ]
        [ div
            [ class "fixtures_step fixtures_step-1" ]
            [ div
                [ class "fixtures_step_text fixtures_step_text-1" ]
                [ text "1" ]
            , button
                [ onClick address Update.GenerateFixtures
                , class "fixtures_button fixtures_step-1_button"
                ]
                [ text "create fixtures" ]
            ]
        , div
            [ class "fixtures_step fixtures_step-2" ]
            [ div
                [ class "fixtures_step_text fixtures_step_text-2" ]
                [ text "2" ]
            , button
                [ onClick address Update.Start
                , class "fixtures_button fixtures_step-2_button"
                ]
                [ text "kick off" ]
            ]
        ]
    , div
        []
        [ text <| toString model.gameTime ]
    , div
        []
        (List.map Fixture.view model.fixtures)
    ]
