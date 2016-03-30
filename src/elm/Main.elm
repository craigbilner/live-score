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
main =
  StartApp.start
    { model = Model.model table
    , view = View.view
    , update = Update.update
    }
