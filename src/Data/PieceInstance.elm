module Data.PieceInstance exposing (PieceInstance, class, new, player)

import Data.PieceClass as PieceClass exposing (PieceClass)
import Data.Player as Player exposing (Player)


type alias PieceInstanceData =
    { class : PieceClass
    , player : Player
    }


type PieceInstance
    = PieceInstance PieceInstanceData


new : PieceClass -> Player -> PieceInstance
new pieceClass piecePlayer =
    PieceInstance (PieceInstanceData pieceClass piecePlayer)


class : PieceInstance -> PieceClass
class pieceInstance =
    let
        pieceInstanceData =
            data pieceInstance
    in
    pieceInstanceData.class


player : PieceInstance -> Player
player pieceInstance =
    let
        pieceInstanceData =
            data pieceInstance
    in
    pieceInstanceData.player



---- PRIVATE ----


data : PieceInstance -> PieceInstanceData
data pieceInstance =
    case pieceInstance of
        PieceInstance pieceInstanceData ->
            pieceInstanceData
