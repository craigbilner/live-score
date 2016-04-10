module Table.Update (..) where

import Dict
import Utils
import Table.Model as TableModel
import Fixtures.Model as FM
import PortModel


updateTeam : Dict.Dict Int ( FM.LiveTeam, FM.LiveTeam ) -> PortModel.TeamData -> PortModel.TeamData
updateTeam teams team =
  let
    teamsStatus =
      Utils.safeGetLiveTeams team.id teams

    thisTeamStatus =
      fst teamsStatus

    otherTeamStatus =
      snd teamsStatus

    won =
      if thisTeamStatus.score > otherTeamStatus.score then
        team.won + 1
      else
        team.won

    drawn =
      if thisTeamStatus.score == otherTeamStatus.score then
        team.drawn + 1
      else
        team.drawn

    lost =
      if thisTeamStatus.score < otherTeamStatus.score then
        team.lost + 1
      else
        team.lost
  in
    { team
      | gFor = team.gFor + thisTeamStatus.score
      , gAgainst = team.gAgainst + otherTeamStatus.score
      , won = won
      , drawn = drawn
      , lost = lost
    }


insertTeam : FM.LiveTeam -> FM.LiveTeam -> Dict.Dict Int ( FM.LiveTeam, FM.LiveTeam ) -> Dict.Dict Int ( FM.LiveTeam, FM.LiveTeam )
insertTeam team otherTeam dict =
  Dict.insert team.id ( team, otherTeam ) dict


flattenFixtures : FM.Fixture -> Dict.Dict Int ( FM.LiveTeam, FM.LiveTeam ) -> Dict.Dict Int ( FM.LiveTeam, FM.LiveTeam )
flattenFixtures fixture dict =
  insertTeam (fst fixture.liveFeed.teams) (snd fixture.liveFeed.teams) dict
    |> insertTeam (snd fixture.liveFeed.teams) (fst fixture.liveFeed.teams)


run : TableModel.Model -> List FM.Fixture -> TableModel.Model
run table fixtures =
  let
    newData =
      ((List.foldl flattenFixtures Dict.empty fixtures
          |> updateTeam
       )
        |> List.map
      )
        table.init
  in
    { table | current = newData }
