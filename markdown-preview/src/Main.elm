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
    div [ style container ]
        [ textarea [ placeholder "Text to Markdown", onInput NewContent, style edit ] []
        , Markdown.toHtml [ style preview ] content
        ]


container : List ( String, String )
container =
    [ ( "display", "flex" )
    , ( "height", "100vh" )
    ]


preview : List ( String, String )
preview =
    [ ( "flex", "1" )
    , ( "overflow-y", "scroll" )
    ]


edit : List ( String, String )
edit =
    preview ++ [ ( "resize", "none" ) ]
