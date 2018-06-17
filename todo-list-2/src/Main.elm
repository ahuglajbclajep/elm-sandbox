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
    | RemoveTask Int


update : Msg -> Model -> Model
update msg ({ task, todo } as model) =
    let
        remove index list =
            List.take index list ++ List.drop (index + 1) list
    in
        case msg of
            InputText text ->
                { model | task = text }

            AddTask ->
                if String.isEmpty task then
                    model
                else
                    { model | task = "", todo = task :: todo }

            RemoveTask index ->
                { model | todo = remove index todo }


view : Model -> Html Msg
view { task, todo } =
    let
        viewTodo index todo =
            li [ onClick <| RemoveTask index ] [ text todo ]
    in
        div []
            [ h1 [] [ text "ToDo List" ]
            , input [ placeholder "new task", value task, onInput InputText ] []
            , button [ onClick AddTask ] [ text "add" ]
            , ul [] <| List.indexedMap viewTodo todo
            ]
