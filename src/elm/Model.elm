module Model (..) where

import Table.Model as TableModel
import Fixtures.Model as FixturesModel


type alias Model =
  { table : TableModel.Model
  , fixtures : FixturesModel.Model
  }


model : List TableModel.RawTableTeam -> Model
model table =
  { table = TableModel.Model table
  , fixtures = FixturesModel.Model [] False
  }
