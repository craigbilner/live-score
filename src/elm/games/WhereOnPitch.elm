module Games.WhereOnPitch (..) where

import Random
import Fixtures.Model as FixturesModel
import Utils


run : ( Random.Seed, FixturesModel.Fixture ) -> ( Random.Seed, FixturesModel.Fixture )
run ( seed, fixture ) =
  let
    random =
      Utils.randomInt seed

    num =
      fst random

    newValue =
      case fixture.pitchSide of
        FixturesModel.Left ->
          if num < 10 then
            FixturesModel.Left
          else if num < 20 then
            FixturesModel.Right
          else
            FixturesModel.Neither

        FixturesModel.Right ->
          if num < 10 then
            FixturesModel.Right
          else if num < 20 then
            FixturesModel.Left
          else
            FixturesModel.Neither

        FixturesModel.Neither ->
          if num < 33 then
            FixturesModel.Left
          else if num < 66 then
            FixturesModel.Right
          else
            FixturesModel.Neither
  in
    ( snd random, { fixture | pitchSide = newValue } )
