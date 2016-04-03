module Update (..) where

import Effects exposing (Effects)
import Time exposing (Time)
import Model
import Fixtures.Update as FixturesUpdate
import Fixtures.Model as FixturesModel
import Table.Update as TableUpdate


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
        model =
          { model | fixtures = FixturesUpdate.generateFixtures model.fixtures }
      in
        ( model, Effects.none )

    Start ->
      let
        model =
          { model | isPlaying = True }
      in
        ( model, Effects.none )

    UpdateTime time ->
      let
        newFixtures =
          FixturesUpdate.updateFixtures model.fixtures model.isPlaying

        newTable =
          TableUpdate.updateTable model.table newFixtures.fixtures model.isPlaying

        newModel =
          updateIsPlaying
            { model
              | fixtures = newFixtures
              , table = newTable
            }
      in
        ( newModel, Effects.none )
