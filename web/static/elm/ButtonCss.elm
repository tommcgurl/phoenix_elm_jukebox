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
            , border3 (px 1) solid (hex "#fff")
            , backgroundColor (rgba 216 216 216 0.22)
            , height (px 50)
            , textAlign center
            , alignItems center
            , paddingTop (px 4)
            , justifyContent center
            ]
        , (.) Label
            [ color (hex "#fff")
            , paddingRight (px 16)
            , fontFamilies [ "Avenir Next" ]
            , fontWeight (int 200)
            , fontSize (px 18)
            ]
        ]
