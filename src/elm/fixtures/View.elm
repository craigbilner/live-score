module Fixtures.View (..) where

import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import Fixtures.Model as FixturesModel
import Update


goals : FixturesModel.Goal -> Html.Html
goals { minute, isPenalty } =
  div
    []
    [ text <| toString minute ]


scorers : FixturesModel.Scorer -> Html.Html
scorers scorer =
  div
    []
    [ div
        []
        [ text scorer.name ]
    , div
        []
        (List.map goals scorer.goals)
    ]


aFixture : ( FixturesModel.Team, FixturesModel.Team ) -> Html.Html
aFixture ( home, away ) =
  div
    []
    [ div
        []
        [ div
            []
            [ text home.name ]
        , div
            []
            [ text "VS" ]
        , div
            []
            [ text away.name ]
        ]
    , div
        []
        [ div
            []
            [ text <| toString home.score ]
        , div
            []
            []
        , div
            []
            [ text <| toString away.score ]
        ]
    , div
        []
        [ div
            []
            (List.map scorers home.scorers)
        , div
            []
            []
        , div
            []
            (List.map scorers away.scorers)
        ]
    ]


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
        (List.map aFixture model.fixtures)
    ]
