module Main (..) where

import Html exposing (div, ul, li, text)
import Html.Attributes exposing (style)
import StartApp.Simple as StartApp
import Table.Model as TableModel
import Table.View as TableView
import Table.Update as TableUpdate
import Update


port table : List TableModel.RawTableTeam
type alias Model =
  { table : TableModel.Model
  }


model : Model
model =
  { table = TableModel.Model table
  }


view : Signal.Address Update.Action -> Model -> Html.Html
view address model =
  TableView.view address model.table


update : Update.Action -> Model -> Model
update action model =
  case action of
    _ ->
      model


main =
  StartApp.start { model = model, view = view, update = update }
