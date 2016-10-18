module ChatMessage exposing (..)

import ChatMessageCss
import Html exposing (..)


type alias ChatMessage =
    { body : String
    , user_name : String
    , timestamp : Int
    }


view chatMessage =
    let
        { class } =
            ChatMessageCss.messageNamespace
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
                [ text (toString chatMessage.timestamp) ]
            ]
