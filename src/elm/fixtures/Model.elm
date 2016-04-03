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


type Weather
  = Sunny
  | Rainy
  | Cloudy


type alias Fixture =
  { weather : Weather
  , teams : ( Team, Team )
  }


type alias Model =
  { teams : List Team
  , isGenerated : Bool
  , time : Int
  , fixtures : List Fixture
  }


toMeta : PortModel.TeamData -> Team
toMeta { id, team } =
  Team id team 0 []


init : List PortModel.TeamData -> Int -> Model
init teamData time =
  Model (List.map toMeta teamData) False time []
