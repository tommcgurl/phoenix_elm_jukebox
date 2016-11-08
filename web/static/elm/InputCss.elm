module InputCss exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


inputNamespace =
    withNamespace "input-"


type CssClasses
    = Container
    | Label


css =
    (stylesheet << namespace inputNamespace.name)
        [ (.) Container
            [ displayFlex
            , width (pct 100)
            , border3 (px 1) solid (hex "#979797")
            , backgroundColor (rgba 255 255 255 0.1)
            , height (px 50)
            , paddingLeft (px 24)
            , outline none
            , fontFamilies [ "Avenir Next" ]
            , fontWeight (int 100)
            , fontSize (px 18)
            , color (hex "#FFFFFF")
            , marginBottom (px 32)
            ]
        ]
