module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = Model "" words
        , view = view
        , update = update
        }


type alias Model =
    { keyword : String, founds : List String }


type Msg
    = SearchText String


update : Msg -> Model -> Model
update (SearchText keyword) model =
    { model | keyword = keyword, founds = List.filter (String.contains keyword) words }


view : Model -> Html Msg
view { keyword, founds } =
    div []
        [ input [ placeholder "keyword", value keyword, onInput SearchText ] []
        , ul [] <| List.map (\word -> li [] [ text word ]) founds
        ]


words : List String
words =
    [ "Apple"
    , "Banana"
    , "Cherry"
    , "Grape"
    , "Lemon"
    , "Mango"
    , "Melon"
    , "Orange"
    , "Pear"
    , "Pineapple"
    , "Strawberry"
    , "Watermelon"
    ]
