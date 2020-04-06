module Data.PieceClass exposing (PieceClass(..), toString)


type PieceClass
    = Knight
    | Mage


toString : PieceClass -> String
toString pieceClass =
    case pieceClass of
        Knight ->
            "Knight"

        Mage ->
            "Mage"
