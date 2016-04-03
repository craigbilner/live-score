module Fixtures.Views.FixtureStyles (..) where


card : List ( String, String )
card =
  [ ( "display", "flex" )
  , ( "flex-flow", "column" )
  , ( "margin", "1rem" )
  , ( "padding", "1rem" )
  , ( "max-width", "20rem" )
  , ( "min-height", "10rem" )
  , ( "box-shadow", "0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)" )
  , ( "font-family", "Tahoma" )
  ]


row : List ( String, String )
row =
  [ ( "display", "flex" )
  , ( "justify-content", "space-between" )
  ]
