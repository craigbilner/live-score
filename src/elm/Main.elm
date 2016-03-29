module Main (..) where

import Html exposing (div, ul, li, text)
import Html.Attributes exposing (style)
import StartApp.Simple as StartApp


port table : List RawTableTeam
type alias RawTableTeam =
  { team : String
  , won : Int
  , drawn : Int
  , lost : Int
  , gFor : Int
  , gAgainst : Int
  }


type alias TableTeam =
  { team : String
  , won : Int
  , drawn : Int
  , lost : Int
  , gFor : Int
  , gAgainst : Int
  , played : Int
  , gd : Int
  , points : Int
  , position : Int
  }


type alias Model =
  { table : List RawTableTeam
  }


type Action
  = DoSomething


model : Model
model =
  { table = table
  }


view : Signal.Address Action -> Model -> Html.Html
view address model =
  let
    rows =
      model.table
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
      List.map (mapTable topFourStyle) (fst topFour)

    europeRows =
      List.map (mapTable europeStyle) (fst europe)

    midTableRows =
      List.map (mapTable midStyle) (fst midTable)

    relegationRows =
      List.map (mapTable relegationStyle) (snd midTable)

    htmlRows =
      List.concat [ topFourRows, europeRows, midTableRows, relegationRows ]
  in
    ul
      [ style listStyle ]
      (tableHead :: htmlRows)


update : Action -> Model -> Model
update action model =
  case action of
    _ ->
      model


pointsDescending : TableTeam -> TableTeam -> Order
pointsDescending teamA teamB =
  case compare teamA.points teamB.points of
    LT ->
      GT

    EQ ->
      EQ

    GT ->
      LT


calcTable : RawTableTeam -> TableTeam
calcTable { team, won, drawn, lost, gFor, gAgainst } =
  let
    played =
      won + drawn + lost

    gd =
      gFor - gAgainst

    points =
      (won * 3) + drawn
  in
    TableTeam team won drawn lost gFor gAgainst played gd points 0


applyPositions : Int -> TableTeam -> TableTeam
applyPositions pos team =
  { team | position = pos + 1 }


tableHead : Html.Html
tableHead =
  li
    [ style (listItemStyle ++ headListItemStyle) ]
    [ div
        [ style cellStyle ]
        [ text "pos" ]
    , div
        [ style (cellStyle ++ teamCellStyle) ]
        [ text "team" ]
    , div
        [ style cellStyle ]
        [ text "played" ]
    , div
        [ style cellStyle ]
        [ text "won" ]
    , div
        [ style cellStyle ]
        [ text "drawn" ]
    , div
        [ style cellStyle ]
        [ text "lost" ]
    , div
        [ style cellStyle ]
        [ text "for" ]
    , div
        [ style cellStyle ]
        [ text "against" ]
    , div
        [ style cellStyle ]
        [ text "goal diff." ]
    , div
        [ style cellStyle ]
        [ text "points" ]
    ]


mapTable : List ( String, String ) -> TableTeam -> Html.Html
mapTable customStyle { team, won, drawn, lost, gFor, gAgainst, played, gd, points, position } =
  li
    [ style (listItemStyle ++ customStyle) ]
    [ div
        [ style cellStyle ]
        [ text <| toString position ]
    , div
        [ style (cellStyle ++ teamCellStyle) ]
        [ text team ]
    , div
        [ style cellStyle ]
        [ text <| toString played ]
    , div
        [ style cellStyle ]
        [ text <| toString won ]
    , div
        [ style cellStyle ]
        [ text <| toString drawn ]
    , div
        [ style cellStyle ]
        [ text <| toString lost ]
    , div
        [ style cellStyle ]
        [ text <| toString gFor ]
    , div
        [ style cellStyle ]
        [ text <| toString gAgainst ]
    , div
        [ style cellStyle ]
        [ text <| toString gd ]
    , div
        [ style cellStyle ]
        [ text <| toString points ]
    ]


listStyle : List ( String, String )
listStyle =
  [ ( "list-style-type", "none" )
  , ( "margin", "0" )
  , ( "padding", "0" )
  , ( "width", "700px" )
  , ( "font-family", "Tahoma" )
  , ( "color", "white" )
  ]


listItemStyle : List ( String, String )
listItemStyle =
  [ ( "display", "flex" )
  , ( "flex-flow", "row" )
  , ( "height", "2rem" )
  , ( "align-items", "center" )
  , ( "padding", "0.5rem" )
  , ( "margin", "0.25rem 0" )
  , ( "box-sizing", "border-box" )
  ]


positionStyle : String -> List ( String, String )
positionStyle colour =
  [ ( "background-color", colour )
  ]


topFourStyle : List ( String, String )
topFourStyle =
  positionStyle "rgb(25, 120, 25)"


europeStyle : List ( String, String )
europeStyle =
  positionStyle "rgb(120, 120, 25)"


midStyle : List ( String, String )
midStyle =
  positionStyle "rgb(25, 25, 120)"


relegationStyle : List ( String, String )
relegationStyle =
  positionStyle "rgb(120, 25, 25)"


headListItemStyle : List ( String, String )
headListItemStyle =
  [ ( "color", "white" )
  , ( "text-shadow", "1px 1px 2px rgb(0, 0, 0)" )
  , ( "background-color", "rgb(178, 178, 178)" )
  ]


cellStyle : List ( String, String )
cellStyle =
  [ ( "flex", "1" )
  , ( "text-align", "center" )
  ]


headCellStyle : List ( String, String )
headCellStyle =
  [ ( "background-color", "rgb(192, 192, 192)" )
  , ( "color", "rbg(230, 230, 230)" )
  , ( "text-shadow", "1px 1px 2px black" )
  ]


teamCellStyle : List ( String, String )
teamCellStyle =
  [ ( "flex", "2" )
  , ( "text-align", "left" )
  ]


main =
  StartApp.start { model = model, view = view, update = update }
