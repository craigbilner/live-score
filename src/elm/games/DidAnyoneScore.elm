module Games.DidAnyoneScore (..) where

import Random
import Utils
import Fixtures.Model as FM


canScore : FM.Fixture -> Int -> Bool
canScore fixture id =
  fixture.hasPossession == id && fixture.currentEvent == FM.Shot


hasScored : FM.Fixture -> Int -> Int -> Bool
hasScored fixture id random =
  canScore fixture id && random < 50


getTheOtherTeam : FM.Team -> ( FM.Team, FM.Team ) -> FM.Team
getTheOtherTeam team pair =
  if team.id == (fst pair).id then
    snd pair
  else
    fst pair


testTeam : ( Random.Seed, FM.Fixture, FM.Team, Bool ) -> ( Random.Seed, FM.Fixture, FM.Team, Bool )
testTeam ( seed, fixture, team, teamScored ) =
  let
    random =
      Utils.randomInt seed
  in
    if teamScored || (hasScored fixture team.id (fst random)) then
      ( snd random, fixture, team, True )
    else
      ( snd random, fixture, getTheOtherTeam team fixture.teams, False )


updateScore : FM.Team -> Int -> FM.Team
updateScore team id =
  if team.id == id then
    { team | score = team.score + 1 }
  else
    team


updateTeam : ( Random.Seed, FM.Fixture, FM.Team, Bool ) -> ( Random.Seed, FM.Fixture, Maybe FM.Team )
updateTeam ( seed, fixture, team, hasScored ) =
  if hasScored then
    let
      homeTeam =
        updateScore (fst fixture.teams) team.id

      awayTeam =
        updateScore (snd fixture.teams) team.id
    in
      ( seed, { fixture | teams = ( homeTeam, awayTeam ) }, Just team )
  else
    ( seed, fixture, Nothing )


maybeReset : ( Random.Seed, FM.Fixture, Maybe FM.Team ) -> ( Random.Seed, FM.Fixture )
maybeReset ( seed, fixture, scoringTeam ) =
  case scoringTeam of
    Just team ->
      ( seed
      , { fixture
          | hasPossession = (getTheOtherTeam team fixture.teams).id
          , currentEvent = FM.KickOff
        }
      )

    Nothing ->
      ( seed, fixture )


run : ( Random.Seed, FM.Fixture ) -> ( Random.Seed, FM.Fixture )
run ( seed, fixture ) =
  testTeam ( seed, fixture, fst fixture.teams, False )
    |> testTeam
    |> updateTeam
    |> maybeReset
