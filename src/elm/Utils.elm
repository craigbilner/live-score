module Utils (..) where

import Dict
import Random
import Fixtures.Model as FM


safeGetTeam : Int -> Dict.Dict Int FM.Team -> FM.Team
safeGetTeam key =
  Maybe.withDefault (FM.emptyTeam) << Dict.get key


safeGetTeams : Int -> Dict.Dict Int ( FM.Team, FM.Team ) -> ( FM.Team, FM.Team )
safeGetTeams key =
  Maybe.withDefault ( FM.emptyTeam, FM.emptyTeam ) << Dict.get key


safeGetLiveTeams : Int -> Dict.Dict Int ( FM.LiveTeam, FM.LiveTeam ) -> ( FM.LiveTeam, FM.LiveTeam )
safeGetLiveTeams key =
  Maybe.withDefault ( FM.emptyLiveTeam 0, FM.emptyLiveTeam 0 ) << Dict.get key


randomInt : Random.Seed -> ( Int, Random.Seed )
randomInt =
  Random.generate (Random.int 0 100)
