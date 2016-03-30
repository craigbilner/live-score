module Fixtures.Update (..) where

import Fixtures.Model as FixturesModel


generateFixtures : FixturesModel.Model -> FixturesModel.Model
generateFixtures model =
  model
