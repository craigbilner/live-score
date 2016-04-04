module Model (..) where

import Random
import Time exposing (Time)
import PortModel
import Table.Model as TableModel
import Fixtures.Model as FixturesModel


type alias Model =
  { table : TableModel.Model
  , fixtures : FixturesModel.Model
  , isPlaying : Bool
  }


model : List PortModel.TeamData -> Int -> Model
model table seedInt =
  { table = TableModel.init table
  , fixtures = FixturesModel.init table (Random.initialSeed seedInt)
  , isPlaying = False
  }
