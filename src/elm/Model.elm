module Model (..) where

import PortModel
import Table.Model as TableModel
import Fixtures.Model as FixturesModel


type alias Model =
  { table : TableModel.Model
  , fixtures : FixturesModel.Model
  , isPlaying : Bool
  }


model : List PortModel.TeamData -> Int -> Model
model table time =
  { table = TableModel.init table
  , fixtures = FixturesModel.init table time
  , isPlaying = False
  }
