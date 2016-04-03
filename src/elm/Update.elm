module Update (..) where

import Effects exposing (Effects)
import Time exposing (Time)
import Model
import Fixtures.Update as FixturesUpdate
import Fixtures.Model as FixturesModel


type Action
  = GenerateFixtures
  | Start
  | UpdateTime Time


updateTime : FixturesModel.Model -> Bool -> FixturesModel.Model
updateTime model isPlaying =
  let
    newTime =
      if isPlaying then
        model.gameTime + 1
      else
        model.gameTime
  in
    { model | gameTime = newTime }


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
          updateTime model.fixtures model.isPlaying

        model =
          updateIsPlaying { model | fixtures = newFixtures }
      in
        ( model, Effects.none )
