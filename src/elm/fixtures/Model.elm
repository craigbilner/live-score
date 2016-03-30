module Fixtures.Model (..) where

import PortModel


type alias Team =
  { id : Int
  , name : String
  }


type alias Model =
  { teams : List Team
  , isGenerated : Bool
  }


init : List PortModel.TeamData -> Model
init teamData =
  Model [] False
