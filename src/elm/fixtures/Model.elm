module Fixtures.Model (..) where

import PortModel


type alias Goal =
  { minute : Int
  , isPenalty : Bool
  }


type alias Scorer =
  { name : String
  , goals : List Goal
  }


type alias Team =
  { id : Int
  , name : String
  , score : Int
  , scorers : List Scorer
  }


type alias Model =
  { teams : List Team
  , isGenerated : Bool
  , time : Int
  , fixtures : List ( Team, Team )
  }


toMeta : PortModel.TeamData -> Team
toMeta { id, team } =
  Team id team 0 []


init : List PortModel.TeamData -> Int -> Model
init teamData time =
  Model (List.map toMeta teamData) False time []