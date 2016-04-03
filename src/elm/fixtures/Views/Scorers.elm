module Fixtures.Views.Scorers (..) where

import Html exposing (div, ul, li, text)
import Fixtures.Model as FixturesModel
import Fixtures.Views.Goals as Goals


view : FixturesModel.Scorer -> Html.Html
view scorer =
  li
    []
    [ div
        []
        [ div
            []
            [ text scorer.name ]
        , ul
            []
            (List.map Goals.view scorer.goals)
        ]
    ]
