module Data.Cell exposing (Cell, fromCoordinate, new)


type alias CellData =
    { x : Int
    , y : Int
    }


type Cell
    = Cell CellData


new : Int -> Int -> Cell
new xVal yVal =
    Cell (CellData xVal yVal)


fromCoordinate : ( Int, Int ) -> Cell
fromCoordinate ( xVal, yVal ) =
    new xVal yVal
