module Data.Player exposing (Player(..), toString)


type Player
    = Red
    | Blue


toString : Player -> String
toString player =
    case player of
        Red ->
            "Red"

        Blue ->
            "Blue"
