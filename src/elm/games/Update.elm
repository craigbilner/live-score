module Games.Update (..) where

import Random
import Fixtures.Model as FixturesModel


updateTeam : Int -> FixturesModel.Team -> FixturesModel.Team
updateTeam random team =
  let
    hasScored =
      random < 50

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
  let
    newTime =
      if isPlaying then
        model.gameTime + 1
      else
        model.gameTime

    newGames =
      if isPlaying then
        let
          generator =
            Random.list (List.length model.fixtures) (Random.int 0 100)

          seed1 =
            Random.initialSeed model.seedInt

          seed2 =
            Random.initialSeed (model.seedInt + 1)

          randomList1 =
            Random.generate generator seed1
              |> fst

          randomList2 =
            Random.generate generator seed2
              |> fst

          randomList =
            List.map2 (,) randomList1 randomList2
        in
          List.map2 updateGame model.fixtures randomList
      else
        model.fixtures
  in
    { model
      | gameTime = newTime
      , fixtures = newGames
      , seedInt = model.seedInt + 1
    }
