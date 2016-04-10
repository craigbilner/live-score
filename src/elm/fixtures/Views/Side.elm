module Fixtures.Views.Side (..) where

import Html exposing (div, ul, text)
import Html.Attributes exposing (style)
import Fixtures.Model as FixturesModel
import Fixtures.Views.SideStyles as Styles
import Fixtures.Views.Scorers as Scorers


view : FixturesModel.Team -> FixturesModel.LiveTeam -> Html.Html
view team liveInfo =
  div
    [ style Styles.sideColumn ]
    [ div
        []
        [ text team.name ]
    , div
        [ style Styles.score ]
        [ text <| toString liveInfo.score ]
    , ul
        []
        (List.map Scorers.view liveInfo.scorers)
    ]
