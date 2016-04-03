module Fixtures.Views.Fixture (..) where

import Html exposing (div, text)
import Html.Attributes exposing (style)
import Fixtures.Model as FixturesModel
import Fixtures.Views.Scorers as Scorers
import Fixtures.Views.FixtureStyles as Styles
import Fixtures.Views.Side as Side


view : FixturesModel.Fixture -> Html.Html
view fixture =
  div
    [ style Styles.card ]
    [ div
        [ style Styles.row ]
        [ Side.view (fst fixture.teams)
        , div
            []
            [ text "VS" ]
        , Side.view (snd fixture.teams)
        ]
    ]
