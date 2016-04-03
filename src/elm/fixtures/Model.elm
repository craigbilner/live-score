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


type PitchSide
  = Left
  | Right
  | Neither


type alias Team =
  { id : Int
  , name : String
  , score : Int
  , scorers : List Scorer
  , side : PitchSide
  }


emptyTeam =
  Team 0 "" 0 [] Neither


type Weather
  = Sunny
  | Rainy
  | Cloudy


type alias Fixture =
  { weather : Weather
  , kickOff : Int
  , hasPossession : Int
  , weatherAffected : PitchSide
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
  Team id team 0 [] Neither


init : List PortModel.TeamData -> Int -> Model
init teamData time =
  Model (List.map toMeta teamData) False time []
