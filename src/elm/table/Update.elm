module Table.Update (..) where

import Dict
import Utils
import Table.Model as TableModel
import Fixtures.Model as FM
import PortModel


updateTeam : Dict.Dict Int ( FM.Team, FM.Team ) -> PortModel.TeamData -> PortModel.TeamData
updateTeam teams team =
  let
    teamsStatus =
      Utils.safeGetTeams team.id teams

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


flattenFixtures : FM.Fixture -> Dict.Dict Int ( FM.Team, FM.Team ) -> Dict.Dict Int ( FM.Team, FM.Team )
flattenFixtures fixture dict =
  let
    homeTeam =
      fst fixture.teams

    awayTeam =
      snd fixture.teams

    withHome =
      Dict.insert homeTeam.id ( homeTeam, awayTeam ) dict
  in
    Dict.insert awayTeam.id ( awayTeam, homeTeam ) withHome


updateTable : TableModel.Model -> List FM.Fixture -> Bool -> TableModel.Model
updateTable table fixtures isPlaying =
  let
    flatFixtures =
      List.foldl flattenFixtures Dict.empty fixtures

    newData =
      if isPlaying then
        List.map (updateTeam flatFixtures) table.init
      else
        table.current
  in
    { table | current = newData }
