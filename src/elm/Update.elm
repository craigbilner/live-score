module Update (..) where

import Effects exposing (Effects)
import Time exposing (Time)
import Model
import Fixtures.Update as FixturesUpdate
import Fixtures.Model as FixturesModel
import Table.Update as TableUpdate
import Games.Update as GamesUpdate
import LiveFeed.Update as LiveUpdate


type Action
  = GenerateFixtures
  | Start
  | UpdateTime Time


updateIsPlaying : Model.Model -> Model.Model
updateIsPlaying model =
  let
    isPlaying =
      model.isPlaying && not (model.fixtures.gameTime == 45 || model.fixtures.gameTime == 90)
  in
    { model | isPlaying = isPlaying }


update : Action -> Model.Model -> ( Model.Model, Effects Action )
update action model =
  case action of
    GenerateFixtures ->
      let
        newModel =
          { model | fixtures = (GamesUpdate.play 0) <| FixturesUpdate.generateFixtures model.fixtures }
      in
        ( newModel, Effects.none )

    Start ->
      let
        newModel =
          { model | isPlaying = True }
      in
        ( newModel, Effects.none )

    UpdateTime time ->
      let
        newModel =
          if model.isPlaying then
            { model | fixtures = LiveUpdate.run model.fixtures }
          else
            model
      in
        ( updateIsPlaying newModel, Effects.none )
