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
    [ style ((TableStyles.listItemStyle 0) ++ TableStyles.headListItemStyle) ]
    [ div
        [ style TableStyles.cellStyle ]
        [ text "pos" ]
    , div
        [ style (TableStyles.cellStyle ++ TableStyles.teamCellStyle) ]
        [ text "team" ]
    , div
        [ style TableStyles.cellStyle ]
        [ text "played" ]
    , div
        [ style TableStyles.cellStyle ]
        [ text "won" ]
    , div
        [ style TableStyles.cellStyle ]
        [ text "drawn" ]
    , div
        [ style TableStyles.cellStyle ]
        [ text "lost" ]
    , div
        [ style TableStyles.cellStyle ]
        [ text "for" ]
    , div
        [ style TableStyles.cellStyle ]
        [ text "against" ]
    , div
        [ style TableStyles.cellStyle ]
        [ text "goal diff." ]
    , div
        [ style TableStyles.cellStyle ]
        [ text "points" ]
    ]


mapTable : List ( String, String ) -> TableModel.TableTeam -> Html.Html
mapTable customStyle { team, won, drawn, lost, gFor, gAgainst, played, gd, points, position } =
  li
    [ style ((TableStyles.listItemStyle position) ++ customStyle) ]
    [ div
        [ style TableStyles.cellStyle ]
        [ text <| toString position ]
    , div
        [ style (TableStyles.cellStyle ++ TableStyles.teamCellStyle) ]
        [ text team ]
    , div
        [ style TableStyles.cellStyle ]
        [ text <| toString played ]
    , div
        [ style TableStyles.cellStyle ]
        [ text <| toString won ]
    , div
        [ style TableStyles.cellStyle ]
        [ text <| toString drawn ]
    , div
        [ style TableStyles.cellStyle ]
        [ text <| toString lost ]
    , div
        [ style TableStyles.cellStyle ]
        [ text <| toString gFor ]
    , div
        [ style TableStyles.cellStyle ]
        [ text <| toString gAgainst ]
    , div
        [ style TableStyles.cellStyle ]
        [ text <| toString gd ]
    , div
        [ style TableStyles.cellStyle ]
        [ text <| toString points ]
    ]


view : Signal.Address Update.Action -> TableModel.Model -> Html.Html
view address model =
  let
    rows =
      model.data
        |> List.map calcTable
        |> List.sortWith pointsDescending
        |> List.indexedMap applyPositions

    topFour =
      List.partition (\x -> x.position <= 4) rows

    europe =
      List.partition (\x -> x.position <= 6) (snd topFour)

    midTable =
      List.partition (\x -> x.position <= 17) (snd europe)

    topFourRows =
      List.map (mapTable TableStyles.topFourStyle) (fst topFour)

    europeRows =
      List.map (mapTable TableStyles.europeStyle) (fst europe)

    midTableRows =
      List.map (mapTable TableStyles.midStyle) (fst midTable)

    relegationRows =
      List.map (mapTable TableStyles.relegationStyle) (snd midTable)

    htmlRows =
      List.concat [ topFourRows, europeRows, midTableRows, relegationRows ]
  in
    ul
      [ style TableStyles.listStyle ]
      (tableHead :: htmlRows)
