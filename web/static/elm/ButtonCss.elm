module ButtonCss exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


buttonNamespace =
    withNamespace "button-"


type CssClasses
    = Container
    | Label


css =
    (stylesheet << namespace buttonNamespace.name)
        [ (.) Container
            [ displayFlex
            , borderColor (hex "#fff")
            , backgroundColor (rgba 174 59 36 0.22)
            , height (px 50)
            , textAlign center
            , alignItems center
            , justifyContent center
            ]
        , (.) Label
            [ color (hex "#fff")
            , paddingRight (px 16)
            ]
        ]
