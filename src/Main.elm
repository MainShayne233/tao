module Main exposing (..)

import Browser
import Data.Board as Board exposing (Board)
import Data.Cell as Cell exposing (Cell)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (class, id, src, style)



---- MODEL ----


type alias Model =
    { board : Board }


notInExcludedCoordinates : ( Int, Int ) -> Bool
notInExcludedCoordinates coordinate =
    List.member coordinate
        [ ( 0, 0 )
        , ( 0, 1 )
        , ( 0, 9 )
        , ( 0, 10 )
        , ( 1, 0 )
        , ( 1, 10 )
        , ( 9, 0 )
        , ( 9, 10 )
        , ( 10, 0 )
        , ( 10, 1 )
        , ( 10, 9 )
        , ( 10, 10 )
        ]
        == False


fullGridCoordinates : List ( Int, Int )
fullGridCoordinates =
    List.concatMap
        (\x ->
            List.map (\y -> ( x, y )) (List.range 0 10)
        )
        (List.range 0 10)


initCoordinates : List ( Int, Int )
initCoordinates =
    List.filter notInExcludedCoordinates fullGridCoordinates


initBoard : Board
initBoard =
    Board.new initCoordinates


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
        [ h1 [] [ text "TAO" ]
        , viewBoard model
        ]


viewBoard : Model -> Html Msg
viewBoard model =
    div [ id "board" ] (viewCells model)


viewCells : Model -> List (Html Msg)
viewCells model =
    fullGridCoordinates
        |> List.map
            (\coordinate ->
                case Board.getCell coordinate model.board of
                    Just cell ->
                        viewCell cell

                    Nothing ->
                        div [] []
            )


viewCell : Cell -> Html Msg
viewCell cell =
    div ([] ++ [ class "cell" ]) []


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
