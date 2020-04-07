module Data.Turn exposing (Turn, new, player)

import Data.Player as Player exposing (Player)


type alias TurnData =
    { player : Player
    }


type Turn
    = Turn TurnData


new : Player -> Turn
new turnPlayer =
    Turn (TurnData turnPlayer)


player : Turn -> Player
player turn =
    (data turn).player



---- PRIVATE ----


data : Turn -> TurnData
data cell =
    case cell of
        Turn cellData ->
            cellData
