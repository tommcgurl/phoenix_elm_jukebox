module InputFormCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


inputFormNamespace =
    withNamespace "input-form"


type CssClasses
    = JoinChannelFormContainer
    | MessageFormContainer


css =
    (stylesheet << namespace inputFormNamespace.name)
        [ (.) JoinChannelFormContainer
            [ backgroundColor (rgb 220 81 70)
            , padding (px 10)
            ]
        , (.) MessageFormContainer
            [ backgroundColor (rgb 0 200 200)
            , padding (px 20)
            ]
        ]
