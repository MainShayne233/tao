module Data.Board exposing (Board, getCell, instantiatePiece, new)

import Data.Cell as Cell exposing (Cell)
import Data.PieceClass as PieceClass exposing (PieceClass)
import Data.PieceInstance as PieceInstance exposing (PieceInstance)
import Data.Player as Player exposing (Player)
import Dict exposing (Dict)


type alias CellTable =
    Dict ( Int, Int ) Cell


type alias BoardData =
    { cells : CellTable
    }


type Board
    = Board BoardData


new : List ( Int, Int ) -> Board
new coordinates =
    Board (BoardData (initCells coordinates))


getCell : ( Int, Int ) -> Board -> Maybe Cell
getCell coordinate board =
    Dict.get coordinate (cells board)


instantiatePiece : ( Int, Int ) -> PieceClass -> Player -> Board -> Board
instantiatePiece coordinate pieceClass player board =
    let
        boardCells =
            cells board
    in
    case Dict.get coordinate boardCells of
        Just cell ->
            let
                updatedCell =
                    Cell.setOccupied (PieceInstance.new pieceClass player) cell

                updatedCells =
                    Dict.insert coordinate updatedCell boardCells
            in
            setCells updatedCells board

        Nothing ->
            board



---- PRIVATE ----


setCells : CellTable -> Board -> Board
setCells newCells board =
    let
        boardData =
            data board
    in
    Board { boardData | cells = newCells }


initCells : List ( Int, Int ) -> CellTable
initCells coordinates =
    Dict.fromList (List.map (\coordinate -> ( coordinate, Cell.new )) coordinates)


cells : Board -> CellTable
cells board =
    let
        boardData =
            data board
    in
    boardData.cells


data : Board -> BoardData
data board =
    case board of
        Board boardData ->
            boardData
