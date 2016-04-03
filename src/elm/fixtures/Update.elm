module Fixtures.Update (..) where

import Random
import Dict
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


shuffleTuples : Int -> List ( Int, Int ) -> List ( Int, Int )
shuffleTuples initInt pairs =
  applyRandom (Random.initialSeed initInt) pairs []
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


safeGet : Int -> Dict.Dict Int FixturesModel.Team -> FixturesModel.Team
safeGet key =
  Maybe.withDefault (FixturesModel.emptyTeam) << Dict.get key


pairsToTeams : Dict.Dict Int FixturesModel.Team -> ( Int, Int ) -> ( FixturesModel.Team, FixturesModel.Team )
pairsToTeams dict pair =
  ( safeGet (fst pair) dict, safeGet (snd pair) dict )


generateWeather : Int -> FixturesModel.Weather
generateWeather seed =
  FixturesModel.Sunny


teamsToFixture : Int -> ( FixturesModel.Team, FixturesModel.Team ) -> FixturesModel.Fixture
teamsToFixture initSeedInt pair =
  let
    weather =
      generateWeather initSeedInt

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
        |> shuffleTuples model.time
        |> takeUnique 10 []
        |> List.map (pairsToTeams dict)
  in
    { model | fixtures = List.map (teamsToFixture model.time) teams }
