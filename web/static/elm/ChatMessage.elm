module ChatMessage exposing (..)

import ChatMessageCss
import Time exposing (Time)
import Date exposing (..)
import Html exposing (..)


type alias ChatMessage =
    { body : String
    , user_name : String
    , timestamp : Time
    }


view chatMessage =
    let
        { class } =
            ChatMessageCss.messageNamespace

        date =
            fromTime chatMessage.timestamp

        monthName =
            month date
                |> toString

        weekDay =
            dayOfWeek date
                |> toString

        dayNumber =
            day date
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
