module Table.Model (..) where

import PortModel


type alias TableTeam =
  { team : String
  , won : Int
  , drawn : Int
  , lost : Int
  , gFor : Int
  , gAgainst : Int
  , played : Int
  , gd : Int
  , points : Int
  , position : Int
  }


type alias Model =
  { data : List PortModel.TeamData
  }


init : List PortModel.TeamData -> Model
init teamData =
  Model teamData
