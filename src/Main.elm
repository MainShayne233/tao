module Main exposing (..)

import Browser
import Data.Board as Board exposing (Board)
import Data.Cell as Cell exposing (Cell, CellState)
import Data.PieceClass as PieceClass exposing (PieceClass)
import Data.PieceInstance as PieceInstance exposing (PieceInstance)
import Data.Player as Player exposing (Player)
import Data.Turn as Turn exposing (Phase(..), Turn)
import Html exposing (Html, button, div, h1, img, input, p, text)
import Html.Attributes exposing (class, id, src, style, type_)
import Html.Events exposing (onClick)



---- MODEL ----


type alias Model =
    { board : Board
    , pastTurns : List Turn
    , currentTurn : Turn
    , selectedCell : Maybe ( Int, Int )
    , phase : Phase
    }


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


firstPlayer : Player
firstPlayer =
    Player.Red


init : ( Model, Cmd Msg )
init =
    ( { board = initBoard, pastTurns = [], selectedCell = Nothing, phase = Walk, currentTurn = Turn.new firstPlayer }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp
    | CellClicked ( Int, Int )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        CellClicked coordinate ->
            ( { model | selectedCell = Just coordinate }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ id "app" ]
        [ h1 [] [ text "TAO" ]
        , div [ id "game-container" ]
            [ viewGameInfo model, viewPhaseInfo model, viewBoard model ]
        ]


viewGameInfo : Model -> Html Msg
viewGameInfo model =
    let
        currentPlayerLabel =
            model.currentTurn |> Turn.player |> Player.toString
    in
    div [ id "game-info" ]
        [ p [] [ text (currentPlayerLabel ++ "'s turn") ]
        ]


viewPhaseInfo : Model -> Html Msg
viewPhaseInfo model =
    div []
        [ Html.label []
            [ text "Walk"
            , input [ type_ "radio" ] []
            ]
        , Html.label
            []
            [ text "Attack"
            , input [ type_ "radio" ] []
            ]
        , Html.label
            []
            [ text "Change Direction"
            , input [ type_ "radio" ] []
            ]
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
viewCell cell coordinate =
    let
        ( xVal, yVal ) =
            coordinate

        cellContent =
            case Cell.state cell of
                Cell.Unoccupied ->
                    div [] []

                Cell.Occupied pieceInstance ->
                    viewPieceInstance pieceInstance
    in
    button [ class "cell tooltip", onClick (CellClicked coordinate) ]
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
