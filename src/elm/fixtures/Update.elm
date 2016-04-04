module Fixtures.Update (..) where

import Random
import Dict
import Utils
import Fixtures.Model as FixturesModel


mapTuples : Int -> Int -> List ( Int, Int ) -> List ( Int, Int )
mapTuples base pair all =
  if base /= pair then
    ( base, pair ) :: all
  else
    all


zipUnique : List Int -> List Int -> List ( Int, Int ) -> List ( Int, Int )
zipUnique xs ys all =
  case xs of
    [] ->
      all

    x :: xs' ->
      List.append (List.foldl (mapTuples x) [] ys) all
        |> zipUnique xs' ys


applyRandom : Random.Seed -> List ( Int, Int ) -> List ( Int, ( Int, Int ) ) -> List ( Int, ( Int, Int ) )
applyRandom seed pairs randoms =
  let
    rand =
      Random.generate (Random.int Random.minInt Random.maxInt) seed
  in
    case pairs of
      [] ->
        randoms

      x :: xs ->
        applyRandom (snd rand) xs (( fst rand, x ) :: randoms)


shuffleTuples : Random.Seed -> List ( Int, Int ) -> List ( Int, Int )
shuffleTuples seed pairs =
  applyRandom seed pairs []
    |> List.sortBy fst
    |> List.map snd


matchesAnyPart : ( Int, Int ) -> ( Int, Int ) -> Bool
matchesAnyPart ( idA, idB ) ( idC, idD ) =
  idA == idC || idA == idD || idB == idC || idB == idD


takeUnique : Int -> List ( Int, Int ) -> List ( Int, Int ) -> List ( Int, Int )
takeUnique toTake uniques pairs =
  if (List.length uniques < toTake) == True then
    case pairs of
      [] ->
        pairs

      x :: xs ->
        let
          inList =
            List.any (matchesAnyPart x) uniques
        in
          if inList == True then
            takeUnique toTake uniques xs
          else
            takeUnique toTake (x :: uniques) xs
  else
    uniques


teamToTuple : FixturesModel.Team -> ( Int, FixturesModel.Team )
teamToTuple team =
  ( team.id, team )


pairsToTeams : Dict.Dict Int FixturesModel.Team -> ( Int, Int ) -> ( FixturesModel.Team, FixturesModel.Team )
pairsToTeams dict pair =
  ( Utils.safeGetTeam (fst pair) dict, Utils.safeGetTeam (snd pair) dict )


generateWeather : Random.Seed -> FixturesModel.Weather
generateWeather seed =
  FixturesModel.Sunny


teamsToFixture : Random.Seed -> ( FixturesModel.Team, FixturesModel.Team ) -> FixturesModel.Fixture
teamsToFixture seed pair =
  let
    weather =
      generateWeather seed

    kickOff =
      (fst pair).id

    weatherAffected =
      FixturesModel.Neither
  in
    FixturesModel.Fixture weather kickOff kickOff weatherAffected pair


generateFixtures : FixturesModel.Model -> FixturesModel.Model
generateFixtures model =
  let
    ids =
      List.map .id model.teams

    dict =
      Dict.fromList (List.map teamToTuple model.teams)

    teams =
      zipUnique ids ids []
        |> shuffleTuples model.seed
        |> takeUnique 10 []
        |> List.map (pairsToTeams dict)
  in
    { model | fixtures = List.map (teamsToFixture model.seed) teams }
