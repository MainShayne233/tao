module Data.Cell exposing (Cell, CellState(..), new, setOccupied, state)

import Data.PieceInstance as PieceInstance exposing (PieceInstance)


type CellState
    = Occupied PieceInstance
    | Unoccupied


type alias CellData =
    { state : CellState
    }


type Cell
    = Cell CellData


new : Cell
new =
    Cell (CellData Unoccupied)


setOccupied : PieceInstance -> Cell -> Cell
setOccupied instance cell =
    let
        cellData =
            data cell
    in
    Cell { cellData | state = Occupied instance }


state : Cell -> CellState
state cell =
    let
        cellData =
            data cell
    in
    cellData.state



---- PRIVATE ----


data : Cell -> CellData
data cell =
    case cell of
        Cell cellData ->
            cellData
