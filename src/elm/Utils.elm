module Utils (..) where

import Dict
import Fixtures.Model as FM


safeGetTeam : Int -> Dict.Dict Int FM.Team -> FM.Team
safeGetTeam key =
  Maybe.withDefault (FM.emptyTeam) << Dict.get key


safeGetTeams : Int -> Dict.Dict Int ( FM.Team, FM.Team ) -> ( FM.Team, FM.Team )
safeGetTeams key =
  Maybe.withDefault ( FM.emptyTeam, FM.emptyTeam ) << Dict.get key
