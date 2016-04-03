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


updateGame : FixturesModel.Fixture -> Int -> FixturesModel.Fixture
updateGame fixture random =
  let
    homeTeam =
      fst fixture.teams

    awayTeam =
      snd fixture.teams

    updatedHomeTeam =
      updateTeam random homeTeam

    updatedAwayTeam =
      updateTeam random awayTeam
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

          seed =
            Random.initialSeed model.seedInt

          randomList =
            Random.generate generator seed
              |> fst
        in
          List.map2 updateGame model.fixtures randomList
      else
        model.fixtures
  in
    { model
      | gameTime = newTime
      , fixtures = newGames
    }
