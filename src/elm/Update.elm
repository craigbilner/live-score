module Update (..) where

import Model
import Fixtures.Update as FixturesUpdate


type Action
  = GenerateFixtures


update : Action -> Model.Model -> Model.Model
update action model =
  case action of
    GenerateFixtures ->
      { model | fixtures = FixturesUpdate.generateFixtures model.fixtures }
