module Games.DidAnyoneScore (..) where

import Random
import Utils
import Fixtures.Model as FixturesModel


canScore : FixturesModel.Fixture -> Int -> Bool
canScore fixture id =
  fixture.hasPossession == id && fixture.currentEvent == FixturesModel.Shot


hasScored : FixturesModel.Fixture -> Int -> Int -> Bool
hasScored fixture id random =
  canScore fixture id && random < 50


run : ( Random.Seed, FixturesModel.Fixture ) -> ( Random.Seed, FixturesModel.Fixture )
run ( seed, fixture ) =
  let
    random =
      Utils.randomInt seed

    homeTeam =
      fst fixture.teams

    awayTeam =
      snd fixture.teams

    hasScoredHome =
      hasScored fixture homeTeam.id <| fst random

    updatedHomeTeam =
      if hasScoredHome then
        { homeTeam | score = homeTeam.score + 1 }
      else
        homeTeam

    hasScoredAway =
      hasScored fixture awayTeam.id <| fst random

    updatedAwayTeam =
      if hasScoredAway then
        { awayTeam | score = awayTeam.score + 1 }
      else
        awayTeam

    otherTeam =
      if fixture.hasPossession == homeTeam.id then
        awayTeam.id
      else
        homeTeam.id

    hasPossession =
      if hasScoredHome || hasScoredAway then
        otherTeam
      else
        fixture.hasPossession

    newEvent =
      if hasScoredHome || hasScoredAway then
        FixturesModel.KickOff
      else
        fixture.currentEvent
  in
    ( snd random
    , { fixture
        | teams = ( updatedHomeTeam, updatedAwayTeam )
        , hasPossession = hasPossession
        , currentEvent = newEvent
        , commentary = newEvent :: fixture.commentary
      }
    )
