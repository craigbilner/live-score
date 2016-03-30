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


teamToTuple : FixturesModel.Team -> ( Int, String )
teamToTuple { id, name } =
  ( id, name )


safeGet : Int -> Dict.Dict Int String -> String
safeGet key =
  Maybe.withDefault "" << Dict.get key


pairsToTeams : Dict.Dict Int String -> ( Int, Int ) -> ( FixturesModel.Team, FixturesModel.Team )
pairsToTeams dict pair =
  let
    teamA =
      safeGet (fst pair) dict

    teamB =
      safeGet (snd pair) dict
  in
    ( FixturesModel.Team (fst pair) teamA, FixturesModel.Team (snd pair) teamB )


generateFixtures : FixturesModel.Model -> FixturesModel.Model
generateFixtures model =
  let
    ids =
      List.map .id model.teams

    dict =
      Dict.fromList (List.map teamToTuple model.teams)

    fixtures =
      zipUnique ids ids []
        |> shuffleTuples model.time
        |> List.map (pairsToTeams dict)
  in
    { model | fixtures = fixtures }
