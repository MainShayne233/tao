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



-- TODO we left off here, should use this over in Main.viewPhaseInfo


hasAlreadyDonePhase : Turn -> Phase -> Bool
hasAlreadyDonePhase turn phase =
    let
        turnData =
            data turn

        actions =
            List.map Tuple.first turnData.actions
    in
    List.member phase actions



---- PRIVATE ----


data : Turn -> TurnData
data cell =
    case cell of
        Turn cellData ->
            cellData
