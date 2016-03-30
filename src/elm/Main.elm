module Main (..) where

import Html exposing (div, ul, li, text)
import Html.Attributes exposing (style)
import StartApp.Simple as StartApp
import Table.Model as TableModel
import Fixtures.Model as FixturesModel
import Model
import PortModel
import Update
import View


port table : List PortModel.TeamData
port time : Int
main =
  StartApp.start
    { model = Model.model table time
    , view = View.view
    , update = Update.update
    }
