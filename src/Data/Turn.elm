module Data.Turn exposing (Phase(..), Turn, new, player)

import Data.Player as Player exposing (Player)


type alias TurnData =
    { player : Player
    , actions : List Action
    }


type Turn
    = Turn TurnData


type alias Action =
    ( Phase, ( Int, Int ) )


type Phase
    = Walk
    | Attack
    | ChangeDirection


new : Player -> Turn
new turnPlayer =
    Turn (TurnData turnPlayer [])


player : Turn -> Player
player turn =
    (data turn).player



---- PRIVATE ----


data : Turn -> TurnData
data cell =
    case cell of
        Turn cellData ->
            cellData
