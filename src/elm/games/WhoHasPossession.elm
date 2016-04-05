module Games.WhoHasPossession (..) where

import Random
import Fixtures.Model as FM
import Utils


fromKickOff : Int -> FM.Event -> Int -> Int -> Int
fromKickOff random prevEvent has hasnt =
  case prevEvent of
    FM.KickOff ->
      has

    FM.GoalKick ->
      if random < 50 then
        has
      else
        hasnt

    FM.Corner ->
      if random < 50 then
        has
      else
        hasnt

    FM.Throw ->
      if random < 50 then
        has
      else
        hasnt

    FM.Pass ->
      if random < 99 then
        has
      else
        hasnt

    FM.Tackle ->
      if random < 10 then
        has
      else
        hasnt

    FM.Shot ->
      has


fromGoalKick : Int -> FM.Event -> Int -> Int -> Int
fromGoalKick random prevEvent has hasnt =
  case prevEvent of
    FM.KickOff ->
      hasnt

    FM.GoalKick ->
      if random < 50 then
        has
      else
        hasnt

    FM.Corner ->
      if random < 1 then
        has
      else
        hasnt

    FM.Throw ->
      if random < 5 then
        has
      else
        hasnt

    FM.Pass ->
      if random < 95 then
        has
      else
        hasnt

    FM.Tackle ->
      if random < 50 then
        has
      else
        hasnt

    FM.Shot ->
      if random < 90 then
        has
      else
        hasnt


fromCorner : Int -> FM.Event -> Int -> Int -> Int
fromCorner random prevEvent has hasnt =
  case prevEvent of
    FM.KickOff ->
      if random < 50 then
        has
      else
        hasnt

    FM.GoalKick ->
      if random < 50 then
        has
      else
        hasnt

    FM.Corner ->
      if random < 50 then
        has
      else
        hasnt

    FM.Throw ->
      if random < 50 then
        has
      else
        hasnt

    FM.Pass ->
      if random < 50 then
        has
      else
        hasnt

    FM.Tackle ->
      if random < 50 then
        has
      else
        hasnt

    FM.Shot ->
      if random < 50 then
        has
      else
        hasnt


fromThrow : Int -> FM.Event -> Int -> Int -> Int
fromThrow random prevEvent has hasnt =
  case prevEvent of
    FM.KickOff ->
      if random < 50 then
        has
      else
        hasnt

    FM.GoalKick ->
      if random < 50 then
        has
      else
        hasnt

    FM.Corner ->
      if random < 50 then
        has
      else
        hasnt

    FM.Throw ->
      if random < 50 then
        has
      else
        hasnt

    FM.Pass ->
      if random < 50 then
        has
      else
        hasnt

    FM.Tackle ->
      if random < 50 then
        has
      else
        hasnt

    FM.Shot ->
      if random < 50 then
        has
      else
        hasnt


fromPass : Int -> FM.Event -> Int -> Int -> Int
fromPass random prevEvent has hasnt =
  case prevEvent of
    FM.KickOff ->
      if random < 50 then
        has
      else
        hasnt

    FM.GoalKick ->
      if random < 50 then
        has
      else
        hasnt

    FM.Corner ->
      if random < 50 then
        has
      else
        hasnt

    FM.Throw ->
      if random < 50 then
        has
      else
        hasnt

    FM.Pass ->
      if random < 50 then
        has
      else
        hasnt

    FM.Tackle ->
      if random < 50 then
        has
      else
        hasnt

    FM.Shot ->
      if random < 50 then
        has
      else
        hasnt


fromTackle : Int -> FM.Event -> Int -> Int -> Int
fromTackle random prevEvent has hasnt =
  case prevEvent of
    FM.KickOff ->
      if random < 50 then
        has
      else
        hasnt

    FM.GoalKick ->
      if random < 50 then
        has
      else
        hasnt

    FM.Corner ->
      if random < 50 then
        has
      else
        hasnt

    FM.Throw ->
      if random < 50 then
        has
      else
        hasnt

    FM.Pass ->
      if random < 50 then
        has
      else
        hasnt

    FM.Tackle ->
      if random < 50 then
        has
      else
        hasnt

    FM.Shot ->
      if random < 50 then
        has
      else
        hasnt


fromShot : Int -> FM.Event -> Int -> Int -> Int
fromShot random prevEvent has hasnt =
  case prevEvent of
    FM.KickOff ->
      if random < 50 then
        has
      else
        hasnt

    FM.GoalKick ->
      if random < 50 then
        has
      else
        hasnt

    FM.Corner ->
      if random < 50 then
        has
      else
        hasnt

    FM.Throw ->
      if random < 50 then
        has
      else
        hasnt

    FM.Pass ->
      if random < 50 then
        has
      else
        hasnt

    FM.Tackle ->
      if random < 50 then
        has
      else
        hasnt

    FM.Shot ->
      if random < 50 then
        has
      else
        hasnt


run : ( Random.Seed, FM.Fixture ) -> ( Random.Seed, FM.Fixture )
run ( seed, fixture ) =
  let
    random =
      Utils.randomInt seed

    num =
      fst random

    otherTeam =
      if fixture.hasPossession == (fst fixture.teams).id then
        (snd fixture.teams)
      else
        (fst fixture.teams)

    newValue =
      case fixture.currentEvent of
        FM.KickOff ->
          fromKickOff num fixture.prevEvent fixture.hasPossession otherTeam.id

        FM.GoalKick ->
          fromGoalKick num fixture.prevEvent fixture.hasPossession otherTeam.id

        FM.Corner ->
          fromCorner num fixture.prevEvent fixture.hasPossession otherTeam.id

        FM.Throw ->
          fromThrow num fixture.prevEvent fixture.hasPossession otherTeam.id

        FM.Pass ->
          fromPass num fixture.prevEvent fixture.hasPossession otherTeam.id

        FM.Tackle ->
          fromTackle num fixture.prevEvent fixture.hasPossession otherTeam.id

        FM.Shot ->
          fromShot num fixture.prevEvent fixture.hasPossession otherTeam.id
  in
    ( snd random, { fixture | hasPossession = newValue } )
