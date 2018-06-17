module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = Model "" Partial
        , view = view
        , update = update
        }


type Match
    = Forward
    | Partial
    | Backward


type alias Model =
    { keyword : String, match : Match }


type Msg
    = InputKeyword String
    | ChooseMatch Match


update : Msg -> Model -> Model
update msg model =
    case msg of
        InputKeyword keyword ->
            { model | keyword = keyword }

        ChooseMatch match ->
            { model | match = match }


view : Model -> Html Msg
view { keyword, match } =
    let
        filterWords match keyword =
            case match of
                Forward ->
                    List.filter (String.startsWith keyword) words

                Partial ->
                    List.filter (String.contains keyword) words

                Backward ->
                    List.filter (String.endsWith keyword) words

        emphasizeKeyword keyword =
            List.intersperse (strong [] [ text keyword ]) << List.map text << String.split keyword

        radioButton match message currentMatch =
            label []
                [ input [ type_ "radio", name "match", onClick <| ChooseMatch match, checked <| match == currentMatch ] []
                , text message
                ]
    in
        div []
            [ input [ placeholder "keyword", value keyword, onInput InputKeyword ] []
            , div []
                [ radioButton Forward "forward" match
                , radioButton Partial "partial" match
                , radioButton Backward "backward" match
                ]
            , ul [] <| List.map (li [] << emphasizeKeyword keyword) <| filterWords match keyword
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
