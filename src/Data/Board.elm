module Data.Board exposing (Board, new)

import Data.Cell as Cell exposing (Cell)


type alias BoardData =
    { cells : List Cell
    }


type Board
    = Board BoardData


new : List Cell -> Board
new cells =
    Board (BoardData cells)
