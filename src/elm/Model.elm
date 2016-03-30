module Model (..) where

import PortModel
import Table.Model as TableModel
import Fixtures.Model as FixturesModel


type alias Model =
  { table : TableModel.Model
  , fixtures : FixturesModel.Model
  }


model : List PortModel.TeamData -> Model
model table =
  { table = TableModel.init table
  , fixtures = FixturesModel.init table
  }
