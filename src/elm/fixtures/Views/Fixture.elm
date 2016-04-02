module Fixtures.Views.Fixture (..) where

import Html exposing (div, text)
import Fixtures.Model as FixturesModel
import Fixtures.Views.Scorers as Scorers


view : ( FixturesModel.Team, FixturesModel.Team ) -> Html.Html
view ( home, away ) =
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
            (List.map Scorers.view home.scorers)
        , div
            []
            []
        , div
            []
            (List.map Scorers.view away.scorers)
        ]
    ]
