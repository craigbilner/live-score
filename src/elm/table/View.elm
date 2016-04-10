module Table.View (..) where

import Html exposing (ul, div, li, text)
import Html.Attributes exposing (class, style)
import Table.Model as TableModel
import Table.Update as TableUpdate
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
    [ class "table_head table_row" ]
    [ div
        [ class "table_cell" ]
        [ text "pos" ]
    , div
        [ class "table_cell table_cell--team" ]
        [ text "team" ]
    , div
        [ class "table_cell" ]
        [ text "played" ]
    , div
        [ class "table_cell" ]
        [ text "won" ]
    , div
        [ class "table_cell" ]
        [ text "drawn" ]
    , div
        [ class "table_cell" ]
        [ text "lost" ]
    , div
        [ class "table_cell" ]
        [ text "for" ]
    , div
        [ class "table_cell" ]
        [ text "against" ]
    , div
        [ class "table_cell" ]
        [ text "goal diff." ]
    , div
        [ class "table_cell" ]
        [ text "points" ]
    ]


mapTable : TableModel.TableTeam -> Html.Html
mapTable { team, won, drawn, lost, gFor, gAgainst, played, gd, points, position } =
  li
    [ class "table_row"
    , style [ ( "transform", "translateY(" ++ (toString <| position * 2) ++ "rem)" ) ]
    ]
    [ div
        [ class "table_cell" ]
        [ text <| toString position ]
    , div
        [ class "table_cell table_cell--team" ]
        [ text team ]
    , div
        [ class "table_cell" ]
        [ text <| toString played ]
    , div
        [ class "table_cell" ]
        [ text <| toString won ]
    , div
        [ class "table_cell" ]
        [ text <| toString drawn ]
    , div
        [ class "table_cell" ]
        [ text <| toString lost ]
    , div
        [ class "table_cell" ]
        [ text <| toString gFor ]
    , div
        [ class "table_cell" ]
        [ text <| toString gAgainst ]
    , div
        [ class "table_cell" ]
        [ text <| toString gd ]
    , div
        [ class "table_cell" ]
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
      [ class "table" ]
      (tableHead :: rows)
