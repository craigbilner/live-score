module Fixtures.Model (..) where

import PortModel


type alias Team =
  { id : Int
  , name : String
  }


type alias Model =
  { teams : List Team
  , isGenerated : Bool
  , time : Int
  , fixtures : List ( Team, Team )
  }


toMeta : PortModel.TeamData -> Team
toMeta { id, team } =
  Team id team


init : List PortModel.TeamData -> Int -> Model
init teamData time =
  Model (List.map toMeta teamData) False time []
