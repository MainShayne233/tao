module Data.Cell exposing (Cell, new)


type alias CellData =
    {}


type Cell
    = Cell CellData


new : Cell
new =
    Cell CellData
