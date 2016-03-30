module Update (..) where

import Model


type Action
  = GenerateFixtures


update : Action -> Model.Model -> Model.Model
update action model =
  case action of
    GenerateFixtures ->
      let
        fixtures =
          model.fixtures
      in
        { model | fixtures = { fixtures | isGenerated = True } }
