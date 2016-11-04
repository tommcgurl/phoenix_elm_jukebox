module Button exposing (..)

import ButtonCss
import Html exposing (..)


type alias Label =
    String


view label =
    let
        { class } =
            ButtonCss.buttonNamespace
    in
        div
            [ class [ ButtonCss.Container ] ]
            [ p
                [ class [ ButtonCss.Label ] ]
                [ text label ]
            ]
