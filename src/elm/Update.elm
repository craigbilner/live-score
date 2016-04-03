module Update (..) where

import Effects exposing (Effects)
import Time exposing (Time)
import Model
import Fixtures.Update as FixturesUpdate


type Action
  = GenerateFixtures
  | Start
  | UpdateTime Time


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
        fixtures =
          model.fixtures

        model =
          { model | fixtures = { fixtures | gameTime = fixtures.gameTime + 1 } }
      in
        ( model, Effects.none )
