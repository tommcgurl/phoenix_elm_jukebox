module ChatMessageCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li, input, button)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


messageNamespace =
    withNamespace "message-"


type CssClasses
    = Container
    | MessageAuthor
    | MessageBody
    | MessageTimestamp


css =
    (stylesheet << namespace messageNamespace.name)
        [ class Container
            [ displayFlex ]
        , class MessageAuthor
            [ flex (int 2)
            , paddingRight (px 16)
            ]
        , class MessageBody
            [ flex (int 6)
            ]
        , class MessageTimestamp
            [ flex (int 2)
            , textAlign right
            , paddingRight (px 12)
            ]
        ]
