module Games.UpdateGameHistory (..) where

import Random
import Fixtures.Model as FM


addEvent : FM.Fixture -> FM.Fixture
addEvent fixture =
  let
    gameAction =
      FM.GameAction fixture.currentEvent "" FM.emptyGoal
  in
    { fixture | gameHistory = gameAction :: fixture.gameHistory }


getScoringTeam : FM.Fixture -> Int
getScoringTeam fixture =
  if (fst fixture.teams).id == fixture.hasPossession then
    (snd fixture.teams).id
  else
    (fst fixture.teams).id


addGoal : FM.Fixture -> FM.Fixture
addGoal fixture =
  let
    goalAction =
      FM.GameAction FM.Shot "" (FM.GoalInfo True (FM.Scorer "" []) (getScoringTeam fixture))

    gameAction =
      FM.GameAction fixture.currentEvent "" FM.emptyGoal
  in
    { fixture | gameHistory = gameAction :: goalAction :: fixture.gameHistory }


run : ( Random.Seed, FM.Fixture ) -> ( Random.Seed, FM.Fixture )
run ( seed, fixture ) =
  let
    newFixture =
      addEvent fixture
  in
    if fixture.currentEvent == FM.Shot then
      ( seed, addGoal newFixture )
    else
      ( seed, newFixture )
