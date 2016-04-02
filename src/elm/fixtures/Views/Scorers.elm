module Fixtures.Views.Scorers (..) where

import Html exposing (div, text)
import Fixtures.Model as FixturesModel
import Fixtures.Views.Goals as Goals


view : FixturesModel.Scorer -> Html.Html
view scorer =
  div
    []
    [ div
        []
        [ text scorer.name ]
    , div
        []
        (List.map Goals.view scorer.goals)
    ]
