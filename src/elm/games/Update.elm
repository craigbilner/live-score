module Games.Update (..) where

import Random
import Fixtures.Model as FixturesModel


hasScored : Int -> FixturesModel.Team -> FixturesModel.Team -> Bool
hasScored random thisTeam otherTeam =
  random < 2


updateTeam : Int -> FixturesModel.Team -> FixturesModel.Team -> FixturesModel.Team
updateTeam random thisTeam otherTeam =
  let
    newScore =
      if hasScored random thisTeam otherTeam == True then
        thisTeam.score + 1
      else
        otherTeam.score
  in
    { thisTeam | score = newScore }


updateGame : FixturesModel.Fixture -> ( Int, Int ) -> FixturesModel.Fixture
updateGame fixture ( r1, r2 ) =
  let
    homeTeam =
      fst fixture.teams

    awayTeam =
      snd fixture.teams

    updatedHomeTeam =
      updateTeam r1 homeTeam awayTeam

    updatedAwayTeam =
      updateTeam r2 awayTeam homeTeam
  in
    { fixture | teams = ( updatedHomeTeam, updatedAwayTeam ) }


update : FixturesModel.Model -> Bool -> FixturesModel.Model
update model isPlaying =
  if isPlaying then
    let
      generator =
        Random.list (List.length model.fixtures) (Random.int 0 100)

      randomList1 =
        Random.generate generator model.seed

      randomList2 =
        Random.generate generator (snd randomList1)

      randomList =
        List.map2 (,) (fst randomList1) (fst randomList2)

      newGames =
        List.map2 updateGame model.fixtures randomList
    in
      { model
        | gameTime = model.gameTime + 1
        , fixtures = newGames
        , seed = snd randomList2
      }
  else
    model
