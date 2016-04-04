module Table.Styles (..) where


list : List ( String, String )
list =
  [ ( "list-style-type", "none" )
  , ( "margin", "0" )
  , ( "padding", "0" )
  , ( "width", "700px" )
  , ( "font-family", "Tahoma" )
  , ( "color", "white" )
  , ( "position", "relative" )
  ]


listItem : Int -> List ( String, String )
listItem position =
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


position : String -> List ( String, String )
position colour =
  [ ( "background-color", colour )
  ]


topFour : List ( String, String )
topFour =
  position "rgb(25, 120, 25)"


europe : List ( String, String )
europe =
  position "rgb(120, 120, 25)"


mid : List ( String, String )
mid =
  position "rgb(25, 25, 120)"


relegation : List ( String, String )
relegation =
  position "rgb(120, 25, 25)"


headListItem : List ( String, String )
headListItem =
  [ ( "color", "white" )
  , ( "text-shadow", "1px 1px 2px rgb(0, 0, 0)" )
  , ( "background-color", "rgb(178, 178, 178)" )
  ]


cell : List ( String, String )
cell =
  [ ( "flex", "1" )
  , ( "text-align", "center" )
  ]


headCell : List ( String, String )
headCell =
  [ ( "background-color", "rgb(192, 192, 192)" )
  , ( "color", "rbg(230, 230, 230)" )
  , ( "text-shadow", "1px 1px 2px black" )
  ]


teamCell : List ( String, String )
teamCell =
  [ ( "flex", "2" )
  , ( "text-align", "left" )
  ]
