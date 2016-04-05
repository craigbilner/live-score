module Games.Update (..) where

import Random
import Utils
import Fixtures.Model as FixturesModel
import Games.WhereOnPitch as WhereOnPitch
import Games.WhatEvent as WhatEvent
import Games.WhoHasPossession as WhoHasPossession


hasScored : Int -> Bool
hasScored seedInt =
  let
    random =
      Utils.randomInt (Random.initialSeed seedInt)
  in
    fst random < 50


updateGame : FixturesModel.Fixture -> ( Int, Int ) -> FixturesModel.Fixture
updateGame fixture ( r1, r2 ) =
  let
    homeTeam =
      fst fixture.teams

    awayTeam =
      snd fixture.teams

    newFixture =
      WhatEvent.run ( (Random.initialSeed r1), fixture )
        |> WhereOnPitch.run
        |> WhoHasPossession.run
        |> snd

    hasScoredHome =
      newFixture.hasPossession == homeTeam.id && newFixture.currentEvent == FixturesModel.Shot

    updatedHomeTeam =
      if hasScoredHome then
        { homeTeam | score = homeTeam.score + 1 }
      else
        homeTeam

    hasScoredAway =
      newFixture.hasPossession == awayTeam.id && newFixture.currentEvent == FixturesModel.Shot

    updatedAwayTeam =
      if hasScoredAway then
        { awayTeam | score = awayTeam.score + 1 }
      else
        awayTeam

    otherTeam =
      if newFixture.hasPossession == homeTeam.id then
        awayTeam.id
      else
        homeTeam.id

    hasPossession =
      if hasScoredHome || hasScoredAway then
        otherTeam
      else
        newFixture.hasPossession

    newEvent =
      if hasScoredHome || hasScoredAway then
        FixturesModel.KickOff
      else
        newFixture.currentEvent
  in
    { fixture
      | teams = ( updatedHomeTeam, updatedAwayTeam )
      , hasPossession = hasPossession
      , currentEvent = newEvent
    }


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
