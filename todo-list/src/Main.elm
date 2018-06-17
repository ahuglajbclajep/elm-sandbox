module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = Model "" []
        , view = view
        , update = update
        }


type alias Model =
    { task : String, todo : List String }


type Msg
    = InputText String
    | AddTask


update : Msg -> Model -> Model
update msg ({ task, todo } as model) =
    case msg of
        InputText text ->
            { model | task = text }

        AddTask ->
            if String.isEmpty task then
                model
            else
                { model | task = "", todo = task :: todo }


view : Model -> Html Msg
view { task, todo } =
    div []
        [ input [ placeholder "new task", value task, onInput InputText ] []
        , button [ onClick AddTask ] [ text "add" ]
        , ul [] <| List.map (\task -> li [] [ text task ]) todo
        ]
