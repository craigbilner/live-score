module Fixtures.Model (..) where

import Random
import Time exposing (Time)
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


type Event
  = KickOff
  | GoalKick
  | Corner
  | Throw
  | Pass
  | Tackle
  | Shot


type alias Fixture =
  { weather : Weather
  , kickOff : Int
  , hasPossession : Int
  , weatherAffected : PitchSide
  , teams : ( Team, Team )
  , pitchSide : PitchSide
  , prevEvent : Event
  , currentEvent : Event
  }


type alias Model =
  { teams : List Team
  , isGenerated : Bool
  , seed : Random.Seed
  , fixtures : List Fixture
  , gameTime : Int
  }


toMeta : PortModel.TeamData -> Team
toMeta { id, team } =
  Team id team 0 [] Neither


init : List PortModel.TeamData -> Random.Seed -> Model
init teamData seed =
  Model (List.map toMeta teamData) False seed [] 0
