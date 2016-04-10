module Games.Update (..) where

import Random
import Utils
import Fixtures.Model as FixturesModel
import Games.WhereOnPitch as WhereOnPitch
import Games.WhatEvent as WhatEvent
import Games.WhoHasPossession as WhoHasPossession
import Games.DidAnyoneScore as DidAnyoneScore
import Games.UpdateGameHistory as UpdateGameHistory


updateGame : FixturesModel.Fixture -> Int -> FixturesModel.Fixture
updateGame fixture seedInt =
  let
    newFixture =
      WhatEvent.run ( (Random.initialSeed seedInt), fixture )
        |> WhereOnPitch.run
        |> WhoHasPossession.run
        |> DidAnyoneScore.run
        |> UpdateGameHistory.run
  in
    snd newFixture


update : FixturesModel.Model -> FixturesModel.Model
update model =
  let
    randomList =
      model.seed
        |> (Random.list (List.length model.fixtures) (Random.int 0 100)
              |> Random.generate
           )

    newGames =
      fst randomList
        |> List.map2 updateGame model.fixtures
  in
    { model
      | gameTime = model.gameTime + 1
      , fixtures = newGames
      , seed = snd randomList
    }


play : Int -> FixturesModel.Model -> FixturesModel.Model
play gameTime model =
  if gameTime <= 90 then
    play (gameTime + 1) (update model)
  else
    model
