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


getFixtures : FixturesModel.Model -> Bool -> FixturesModel.Model
getFixtures model isPlaying =
  let
    newTime =
      if isPlaying then
        model.gameTime + 1
      else
        model.gameTime
  in
    { model | gameTime = newTime }


updateTime : Model.Model -> Model.Model
updateTime model =
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
          getFixtures model.fixtures model.isPlaying

        model =
          updateTime { model | fixtures = newFixtures }
      in
        ( model, Effects.none )
