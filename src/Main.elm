module Main exposing (..)

import Browser
import Data.Board as Board exposing (Board)
import Data.Cell as Cell exposing (Cell)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


type alias Model =
    { board : Board }


notInExcludedCells : Cell -> Bool
notInExcludedCells cell =
    List.member cell
        [ Cell.new 0 0
        , Cell.new 0 1
        , Cell.new 1 0
        , Cell.new 0 10
        , Cell.new 0 11
        , Cell.new 1 11
        , Cell.new 9 0
        , Cell.new 9 10
        , Cell.new 10 0
        , Cell.new 10 1
        , Cell.new 10 9
        , Cell.new 10 10
        ]
        == False


initCells : List Cell
initCells =
    let
        grid =
            List.concatMap
                (\x ->
                    List.map (\y -> Cell.new x y) (List.range 0 10)
                )
                (List.range 0 10)
    in
    List.filter notInExcludedCells grid


initBoard : Board
initBoard =
    Board.new initCells


init : ( Model, Cmd Msg )
init =
    ( { board = initBoard }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ viewBoard model
        ]


viewBoard : Model -> Html Msg
viewBoard model =
    div [] []



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
