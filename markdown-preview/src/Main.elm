module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown


main : Program Never Model Msg
main =
    beginnerProgram
        { model = ""
        , view = view
        , update = update
        }


type alias Model =
    String


type Msg
    = NewContent String


update : Msg -> Model -> Model
update (NewContent content) _ =
    content


view : Model -> Html Msg
view content =
    div [ class "container" ]
        [ textarea [ placeholder "Please input Markdown.", onInput NewContent, class "edit" ] []
        , Markdown.toHtml [ class "preview" ] content
        ]
