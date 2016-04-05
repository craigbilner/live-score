module Games.WhatEvent (..) where

import Random
import Fixtures.Model as FM
import Utils


run : ( Random.Seed, FM.Fixture ) -> ( Random.Seed, FM.Fixture )
run ( seed, fixture ) =
  let
    random =
      Utils.randomInt seed

    num =
      fst random

    newValue =
      case fixture.prevEvent of
        FM.KickOff ->
          if num < 1 then
            FM.GoalKick
          else if num < 2 then
            FM.Corner
          else if num < 3 then
            FM.Throw
          else if num < 90 then
            FM.Pass
          else if num < 99 then
            FM.Tackle
          else
            FM.Shot

        FM.GoalKick ->
          if num < 1 then
            FM.GoalKick
          else if num < 2 then
            FM.Corner
          else if num < 10 then
            FM.Throw
          else if num < 55 then
            FM.Pass
          else if num < 95 then
            FM.Tackle
          else
            FM.Shot

        FM.Corner ->
          if num < 30 then
            FM.GoalKick
          else if num < 55 then
            FM.Corner
          else if num < 65 then
            FM.Throw
          else if num < 75 then
            FM.Pass
          else if num < 85 then
            FM.Tackle
          else
            FM.Shot

        FM.Throw ->
          if fixture.pitchSide /= FM.Neither && num < 1 then
            FM.GoalKick
          else if fixture.pitchSide /= FM.Neither && num < 2 then
            FM.Corner
          else if num < 10 then
            FM.Throw
          else if num < 55 then
            FM.Pass
          else if num < 99 then
            FM.Tackle
          else
            FM.Shot

        FM.Pass ->
          if fixture.pitchSide /= FM.Neither && num < 10 then
            FM.GoalKick
          else if fixture.pitchSide /= FM.Neither && num < 11 then
            FM.Corner
          else if num < 12 then
            FM.Throw
          else if fixture.pitchSide /= FM.Neither && num < 52 then
            FM.Pass
          else if num < 62 then
            FM.Pass
          else if num < 92 then
            FM.Tackle
          else
            FM.Shot

        FM.Tackle ->
          if fixture.pitchSide /= FM.Neither && num < 1 then
            FM.GoalKick
          else if fixture.pitchSide /= FM.Neither && num < 30 then
            FM.Corner
          else if num < 10 then
            FM.Throw
          else if num < 90 then
            FM.Pass
          else if num < 95 then
            FM.Tackle
          else
            FM.Shot

        FM.Shot ->
          if fixture.pitchSide /= FM.Neither && num < 75 then
            FM.GoalKick
          else if num < 10 then
            FM.GoalKick
          else if num < 12 then
            FM.Corner
          else if fixture.pitchSide /= FM.Neither && num < 75 then
            FM.Corner
          else if num < 13 then
            FM.Throw
          else if fixture.pitchSide /= FM.Neither && num < 80 then
            FM.Pass
          else if num < 95 then
            FM.Pass
          else
            FM.Tackle
  in
    ( snd random
    , { fixture
        | prevEvent = fixture.currentEvent
        , currentEvent = newValue
      }
    )
