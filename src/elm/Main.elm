module Main (..) where

import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp


main =
  StartApp.start { model = model, view = view, update = update }


type alias Model =
  Int


model : Model
model =
  0


view : Signal.Address Action -> Model -> Html.Html
view address model =
  div
    []
    [ text "some live score thing" ]


type Action
  = DoSomething


update : Action -> Model -> Model
update action model =
  case action of
    _ ->
      model + 1
