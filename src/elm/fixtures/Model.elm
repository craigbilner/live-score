module Fixtures.Model (..) where


type alias Team =
  { id : Int
  , name : String
  }


type alias Model =
  { teams : List Team
  , isGenerated : Bool
  }
