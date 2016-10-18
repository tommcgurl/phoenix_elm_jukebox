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
        [ (.) Container
            [ displayFlex ]
        , (.) MessageAuthor
            [ flex (int 2)
            , paddingRight (px 16)
            ]
        , (.) MessageBody
            [ flex (int 6)
            ]
        , (.) MessageTimestamp
            [ flex (int 2)
            , textAlign right
            , paddingRight (px 12)
            ]
        ]
