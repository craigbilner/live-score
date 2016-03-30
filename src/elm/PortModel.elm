module PortModel (..) where


type alias TeamData =
  { id : Int
  , team : String
  , won : Int
  , drawn : Int
  , lost : Int
  , gFor : Int
  , gAgainst : Int
  }
