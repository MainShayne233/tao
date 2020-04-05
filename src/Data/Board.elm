module Data.Board exposing (Board, getCell, new)

import Data.Cell as Cell exposing (Cell)
import Dict exposing (Dict)


type alias BoardData =
    { cells : Dict ( Int, Int ) Cell
    }


type Board
    = Board BoardData


new : List ( Int, Int ) -> Board
new coordinates =
    Board (BoardData (initCells coordinates))


getCell : ( Int, Int ) -> Board -> Maybe Cell
getCell coordinate board =
    Dict.get coordinate (cells board)



---- PRIVATE ----


initCells : List ( Int, Int ) -> Dict ( Int, Int ) Cell
initCells coordinates =
    Dict.fromList (List.map (\coordinate -> ( coordinate, Cell.new )) coordinates)


cells : Board -> Dict ( Int, Int ) Cell
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
