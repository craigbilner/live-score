module Table.View (..) where

import Html exposing (ul, div, li, text)
import Html.Attributes exposing (style)
import Table.Model as TableModel
import Table.Update as TableUpdate
import Table.Styles as TableStyles
import Update
import PortModel


pointsDescending : TableModel.TableTeam -> TableModel.TableTeam -> Order
pointsDescending teamA teamB =
  case compare teamA.points teamB.points of
    LT ->
      GT

    EQ ->
      EQ

    GT ->
      LT


calcTable : PortModel.TeamData -> TableModel.TableTeam
calcTable { team, won, drawn, lost, gFor, gAgainst } =
  let
    played =
      won + drawn + lost

    gd =
      gFor - gAgainst

    points =
      (won * 3) + drawn
  in
    TableModel.TableTeam team won drawn lost gFor gAgainst played gd points 0


applyPositions : Int -> TableModel.TableTeam -> TableModel.TableTeam
applyPositions pos team =
  { team | position = pos + 1 }


tableHead : Html.Html
tableHead =
  li
    [ style ((TableStyles.listItem 0) ++ TableStyles.headListItem) ]
    [ div
        [ style TableStyles.cell ]
        [ text "pos" ]
    , div
        [ style (TableStyles.cell ++ TableStyles.teamCell) ]
        [ text "team" ]
    , div
        [ style TableStyles.cell ]
        [ text "played" ]
    , div
        [ style TableStyles.cell ]
        [ text "won" ]
    , div
        [ style TableStyles.cell ]
        [ text "drawn" ]
    , div
        [ style TableStyles.cell ]
        [ text "lost" ]
    , div
        [ style TableStyles.cell ]
        [ text "for" ]
    , div
        [ style TableStyles.cell ]
        [ text "against" ]
    , div
        [ style TableStyles.cell ]
        [ text "goal diff." ]
    , div
        [ style TableStyles.cell ]
        [ text "points" ]
    ]


getRowStyle : Int -> List ( String, String )
getRowStyle position =
  if position <= 4 then
    TableStyles.topFour
  else if position <= 6 then
    TableStyles.europe
  else if position <= 17 then
    TableStyles.mid
  else
    TableStyles.relegation


mapTable : TableModel.TableTeam -> Html.Html
mapTable { team, won, drawn, lost, gFor, gAgainst, played, gd, points, position } =
  let
    customStyle =
      getRowStyle position
  in
    li
      [ style ((TableStyles.listItem position) ++ customStyle) ]
      [ div
          [ style TableStyles.cell ]
          [ text <| toString position ]
      , div
          [ style (TableStyles.cell ++ TableStyles.teamCell) ]
          [ text team ]
      , div
          [ style TableStyles.cell ]
          [ text <| toString played ]
      , div
          [ style TableStyles.cell ]
          [ text <| toString won ]
      , div
          [ style TableStyles.cell ]
          [ text <| toString drawn ]
      , div
          [ style TableStyles.cell ]
          [ text <| toString lost ]
      , div
          [ style TableStyles.cell ]
          [ text <| toString gFor ]
      , div
          [ style TableStyles.cell ]
          [ text <| toString gAgainst ]
      , div
          [ style TableStyles.cell ]
          [ text <| toString gd ]
      , div
          [ style TableStyles.cell ]
          [ text <| toString points ]
      ]


view : Signal.Address Update.Action -> TableModel.Model -> Html.Html
view address model =
  let
    rows =
      model.current
        |> List.map calcTable
        |> List.sortWith pointsDescending
        |> List.indexedMap applyPositions
        |> List.sortBy .team
        |> List.map mapTable
  in
    ul
      [ style TableStyles.list ]
      (tableHead :: rows)
