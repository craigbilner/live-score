module Fixtures.Views.Side (..) where

import Html exposing (div, ul, text)
import Html.Attributes exposing (style)
import Fixtures.Model as FixturesModel
import Fixtures.Views.SideStyles as Styles
import Fixtures.Views.Scorers as Scorers


view : FixturesModel.Team -> Html.Html
view team =
  div
    [ style Styles.sideColumn ]
    [ div
        []
        [ text team.name ]
    , div
        [ style Styles.score ]
        [ text <| toString team.score ]
    , ul
        []
        (List.map Scorers.view team.scorers)
    ]
