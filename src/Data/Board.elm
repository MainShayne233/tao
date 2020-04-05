module Data.Board exposing (Board, getCell, mapCells, new)

import Data.Cell as Cell exposing (Cell)


type alias BoardData =
    { cells : List Cell
    }


type Board
    = Board BoardData


new : List Cell -> Board
new initCells =
    Board (BoardData initCells)


mapCells : (Cell -> a) -> Board -> List a
mapCells fun board =
    board
        |> cells
        |> List.map fun


getCell : ( Int, Int ) -> Board -> Maybe Cell
getCell coordinate board =
    let
        cellToFind =
            Cell.fromCoordinate coordinate
    in
    case List.filter (\cell -> cell == cellToFind) (cells board) of
        cell :: rest ->
            Just cell

        [] ->
            Nothing



---- PRIVATE ----


cells : Board -> List Cell
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
