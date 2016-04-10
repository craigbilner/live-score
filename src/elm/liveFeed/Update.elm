module LiveFeed.Update (..) where

import Fixtures.Model as FixturesModel


updateTeam : FixturesModel.GoalInfo -> FixturesModel.LiveTeam -> FixturesModel.LiveTeam
updateTeam goalInfo team =
  if goalInfo.team == team.id then
    { team | score = team.score + 1 }
  else
    team


addGoal : FixturesModel.GoalInfo -> FixturesModel.LiveFeed -> FixturesModel.LiveFeed
addGoal goalInfo liveFeed =
  let
    homeTeam =
      updateTeam goalInfo <| fst liveFeed.teams

    awayTeam =
      updateTeam goalInfo <| snd liveFeed.teams
  in
    { liveFeed | teams = ( homeTeam, awayTeam ) }


updateFeed : FixturesModel.GameAction -> FixturesModel.LiveFeed -> FixturesModel.LiveFeed
updateFeed { event, commentary, goalInfo } liveFeed =
  if goalInfo.hasScored then
    (addGoal goalInfo liveFeed)
  else
    liveFeed


update : FixturesModel.Fixture -> FixturesModel.Fixture
update fixture =
  case fixture.gameHistory of
    [] ->
      fixture

    x :: xs ->
      { fixture
        | liveFeed = updateFeed x fixture.liveFeed
        , gameHistory = xs
      }


run : FixturesModel.Model -> FixturesModel.Model
run model =
  { model
    | fixtures = List.map update model.fixtures
    , gameTime = model.gameTime + 1
  }
