module Main (..) where

import Html exposing (div, ul, li, text)
import Html.Attributes exposing (style)
import StartApp.Simple as StartApp


port table : List TableTeam
type alias TableTeam =
  { team : String
  , won : Int
  , drawn : Int
  , lost : Int
  , gFor : Int
  , gAgainst : Int
  }


type alias Model =
  { table : List TableTeam
  }


type Action
  = DoSomething


model : Model
model =
  { table = table
  }


view : Signal.Address Action -> Model -> Html.Html
view address model =
  ul
    [ style listStyle ]
    (List.map mapTable model.table)


update : Action -> Model -> Model
update action model =
  case action of
    _ ->
      model


mapTable : TableTeam -> Html.Html
mapTable { team, won, drawn, lost, gFor, gAgainst } =
  li
    [ style listItemStyle ]
    [ div
        [ style (cellStyle ++ teamCellStyle) ]
        [ text team ]
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
    ]


listStyle : List ( String, String )
listStyle =
  [ ( "list-style-type", "none" )
  , ( "margin", "0" )
  , ( "padding", "0" )
  , ( "width", "400px" )
  ]


listItemStyle : List ( String, String )
listItemStyle =
  [ ( "display", "flex" )
  , ( "flex-flow", "row" )
  ]


cellStyle : List ( String, String )
cellStyle =
  [ ( "flex", "1" )
  ]


teamCellStyle : List ( String, String )
teamCellStyle =
  [ ( "flex", "2" )
  ]


main =
  StartApp.start { model = model, view = view, update = update }
