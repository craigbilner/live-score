module Fixtures.Views.Goals (..) where

import Html exposing (div, text)
import Fixtures.Model as FixturesModel


view : FixturesModel.Goal -> Html.Html
view { minute, isPenalty } =
  div
    []
    [ text <| toString minute ]
