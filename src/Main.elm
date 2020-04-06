module Main exposing (..)

import Browser
import Data.Board as Board exposing (Board)
import Data.Cell as Cell exposing (Cell, CellState)
import Data.PieceClass as PieceClass exposing (PieceClass)
import Data.PieceInstance as PieceInstance exposing (PieceInstance)
import Data.Player as Player exposing (Player)
import Html exposing (Html, div, h1, img, p, text)
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
        |> placeInitialPieces


placeInitialPieces : Board -> Board
placeInitialPieces board =
    [ ( ( 2, 4 ), PieceClass.Knight, Player.Red )
    , ( ( 2, 5 ), PieceClass.Knight, Player.Red )
    , ( ( 2, 6 ), PieceClass.Knight, Player.Red )
    , ( ( 8, 4 ), PieceClass.Knight, Player.Blue )
    , ( ( 8, 5 ), PieceClass.Knight, Player.Blue )
    , ( ( 8, 6 ), PieceClass.Knight, Player.Blue )
    ]
        |> List.foldl placePiece board


placePiece : ( ( Int, Int ), PieceClass, Player ) -> Board -> Board
placePiece ( coordinate, pieceClass, player ) board =
    Board.instantiatePiece coordinate pieceClass player board


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
    div [ id "app" ]
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
                        viewCell cell coordinate

                    Nothing ->
                        div [] []
            )


viewCell : Cell -> ( Int, Int ) -> Html Msg
viewCell cell ( xVal, yVal ) =
    let
        cellContent =
            case Cell.state cell of
                Cell.Unoccupied ->
                    div [] []

                Cell.Occupied pieceInstance ->
                    viewPieceInstance pieceInstance
    in
    div ([] ++ [ class "cell tooltip" ])
        [ cellContent
        , p [ class "tooltiptext" ] [ text (String.fromInt xVal ++ " : " ++ String.fromInt yVal) ]
        ]


viewPieceInstance : PieceInstance -> Html Msg
viewPieceInstance pieceInstance =
    let
        pieceClass =
            PieceInstance.class pieceInstance

        player =
            PieceInstance.player pieceInstance
    in
    div [ class ("piece-instance " ++ Player.toString player) ]
        [ p [] [ text (PieceClass.toString pieceClass) ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
