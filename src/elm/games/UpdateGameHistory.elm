module Games.UpdateGameHistory (..) where

import Random
import Fixtures.Model as FM


updateCommentary : ( Random.Seed, FM.Fixture ) -> ( Random.Seed, FM.Fixture )
updateCommentary ( seed, fixture ) =
  ( seed, { fixture | commentary = fixture.currentEvent :: fixture.commentary } )


run : ( Random.Seed, FM.Fixture ) -> ( Random.Seed, FM.Fixture )
run ( seed, fixture ) =
  updateCommentary ( seed, fixture )
