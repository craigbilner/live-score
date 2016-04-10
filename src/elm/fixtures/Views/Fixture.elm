module Fixtures.Views.Fixture (..) where

import Html exposing (div, ul, li, text)
import Html.Attributes exposing (style)
import Fixtures.Model as FixturesModel
import Fixtures.Views.Scorers as Scorers
import Fixtures.Views.FixtureStyles as Styles
import Fixtures.Views.Side as Side


commentaryLine : String -> Html.Html
commentaryLine line =
  li
    []
    [ text line ]


view : FixturesModel.Fixture -> Html.Html
view fixture =
  let
    kickingOff =
      if fixture.kickOff == (fst fixture.teams).id then
        fst fixture.teams
      else
        snd fixture.teams
  in
    div
      [ style Styles.card ]
      [ div
          [ style Styles.row ]
          [ Side.view (fst fixture.teams) (fst fixture.liveFeed.teams)
          , div
              []
              [ text "VS" ]
          , Side.view (snd fixture.teams) (snd fixture.liveFeed.teams)
          ]
      , div
          []
          [ text kickingOff.name ]
      , ul
          []
          (List.map commentaryLine fixture.liveFeed.commentary)
      ]
