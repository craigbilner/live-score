module Table.Styles (..) where


listStyle : List ( String, String )
listStyle =
  [ ( "list-style-type", "none" )
  , ( "margin", "0" )
  , ( "padding", "0" )
  , ( "width", "700px" )
  , ( "font-family", "Tahoma" )
  , ( "color", "white" )
  , ( "position", "relative" )
  ]


listItemStyle : Int -> List ( String, String )
listItemStyle position =
  [ ( "display", "flex" )
  , ( "flex-flow", "row" )
  , ( "height", "2rem" )
  , ( "align-items", "center" )
  , ( "padding", "0.5rem" )
  , ( "box-sizing", "border-box" )
  , ( "position", "absolute" )
  , ( "width", "100%" )
  , ( "transform", "translateY(" ++ (toString (position * 2)) ++ "rem)" )
  , ( "transition", "transform 0.5s ease-out" )
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
