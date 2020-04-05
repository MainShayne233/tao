module Data.Cell exposing (Cell, new)


type alias CellData =
    { x : Int
    , y : Int
    }


type Cell
    = Cell CellData


new : Int -> Int -> Cell
new xVal yVal =
    Cell (CellData xVal yVal)
