module Table.Update (..) where

import Dict
import Table.Model as TableModel
import Fixtures.Model as FixturesModel
import PortModel


updateTeam : Dict.Dict Int FixturesModel.Team -> PortModel.TeamData -> PortModel.TeamData
updateTeam teams team =
  { team | gFor = team.gFor + 1 }


updateTable : TableModel.Model -> List FixturesModel.Fixture -> Bool -> TableModel.Model
updateTable table fixtures isPlaying =
  let
    flatFixtures =
      Dict.empty

    newData =
      if isPlaying then
        List.map (updateTeam flatFixtures) table.data
      else
        table.data
  in
    { table | data = newData }
