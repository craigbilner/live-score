module Games.Update (..) where

import Random
import Fixtures.Model as FixturesModel


updateTeam : Int -> FixturesModel.Team -> FixturesModel.Team
updateTeam random team =
  let
    hasScored =
      random < 10

    newScore =
      if hasScored == True then
        team.score + 1
      else
        team.score
  in
    { team | score = newScore }


updateGame : FixturesModel.Fixture -> ( Int, Int ) -> FixturesModel.Fixture
updateGame fixture ( r1, r2 ) =
  let
    homeTeam =
      fst fixture.teams

    awayTeam =
      snd fixture.teams

    updatedHomeTeam =
      updateTeam r1 homeTeam

    updatedAwayTeam =
      updateTeam r2 awayTeam
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
