module Table.Model (..) where


type alias RawTableTeam =
  { team : String
  , won : Int
  , drawn : Int
  , lost : Int
  , gFor : Int
  , gAgainst : Int
  }


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
  { data : List RawTableTeam
  }
