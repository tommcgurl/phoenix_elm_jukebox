module ChatMessage exposing (..)

import ChatMessageCss
import Time exposing (Time)
import Date
import Html exposing (..)


type alias ChatMessage =
    { body : String
    , user_name : String
    , timestamp : String
    }


view chatMessage =
    let
        { class } =
            ChatMessageCss.messageNamespace

        -- We use Result.withDefault here because converting a string to a date may fail for invalid
        -- strings
        date =
            Date.fromString chatMessage.timestamp
                |> Result.withDefault (Date.fromTime 0)

        monthName =
            Date.month date
                |> toString

        weekDay =
            Date.dayOfWeek date
                |> toString

        dayNumber =
            Date.day date
                |> toString
    in
        div
            [ class [ ChatMessageCss.Container ] ]
            [ p
                [ class [ ChatMessageCss.MessageAuthor ] ]
                [ text chatMessage.user_name ]
            , p
                [ class [ ChatMessageCss.MessageBody ] ]
                [ text chatMessage.body ]
            , p
                [ class [ ChatMessageCss.MessageTimestamp ] ]
                [ text (weekDay ++ " " ++ monthName ++ " " ++ dayNumber) ]
            ]
