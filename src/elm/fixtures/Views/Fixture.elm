module Fixtures.Views.Fixture (..) where

import Html exposing (div, text)
import Html.Attributes exposing (style)
import Fixtures.Model as FixturesModel
import Fixtures.Views.Scorers as Scorers
import Fixtures.Views.FixtureStyles as Styles
import Fixtures.Views.Side as Side


view : ( FixturesModel.Team, FixturesModel.Team ) -> Html.Html
view ( home, away ) =
  div
    [ style Styles.card ]
    [ div
        [ style Styles.row ]
        [ Side.view home
        , div
            []
            [ text "VS" ]
        , Side.view away
        ]
    ]
