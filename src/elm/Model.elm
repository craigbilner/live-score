module Model (..) where

import PortModel
import Table.Model as TableModel
import Fixtures.Model as FixturesModel
import Time exposing (Time)


type alias Model =
  { table : TableModel.Model
  , fixtures : FixturesModel.Model
  , isPlaying : Bool
  }


model : List PortModel.TeamData -> Int -> Model
model table seedInt =
  { table = TableModel.init table
  , fixtures = FixturesModel.init table seedInt
  , isPlaying = False
  }
