module Fixtures.Views.Side (..) where

import Html exposing (div, ul, text)
import Html.Attributes exposing (class)
import Fixtures.Model as FixturesModel
import Fixtures.Views.Scorers as Scorers


view : FixturesModel.Team -> FixturesModel.LiveTeam -> Html.Html
view team liveInfo =
  div
    [ class "fixtures_card_row_column" ]
    [ div
        []
        [ text team.name ]
    , div
        [ class "fixtures_card_row_column_score" ]
        [ text <| toString liveInfo.score ]
    , ul
        []
        (List.map Scorers.view liveInfo.scorers)
    ]
