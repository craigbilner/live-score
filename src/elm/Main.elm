module Main (..) where

import StartApp
import Task
import Effects exposing (Never, Effects)
import Time exposing (second)
import Model
import PortModel
import Update
import View


port table : List PortModel.TeamData
port time : Int
app =
  StartApp.start
    { init = init
    , update = Update.update
    , view = View.view
    , inputs = []
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


init : ( Model.Model, Effects Update.Action )
init =
  ( Model.model table time, Effects.none )


input =
  Time.every second
