module Games.Update (..) where

import Random
import Utils
import Fixtures.Model as FixturesModel
import Games.WhereOnPitch as WhereOnPitch
import Games.WhatEvent as WhatEvent
import Games.WhoHasPossession as WhoHasPossession
import Games.DidAnyoneScore as DidAnyoneScore


updateGame : FixturesModel.Fixture -> ( Int, Int ) -> FixturesModel.Fixture
updateGame fixture ( r1, r2 ) =
  let
    newFixture =
      WhatEvent.run ( (Random.initialSeed r1), fixture )
        |> WhereOnPitch.run
        |> WhoHasPossession.run
        |> DidAnyoneScore.run
  in
    snd newFixture


update : FixturesModel.Model -> FixturesModel.Model
update model =
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


play : Int -> FixturesModel.Model -> FixturesModel.Model
play gameTime model =
  if gameTime < 90 then
    play (gameTime + 1) (update model)
  else
    model
