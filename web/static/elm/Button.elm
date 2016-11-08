module Button exposing (..)

import ButtonCss
import Html exposing (..)


type alias Label =
    String


view attributes label =
    let
        { class } =
            ButtonCss.buttonNamespace

        newAttributes =
            List.append attributes [ class [ ButtonCss.Container ] ]
    in
        div
            newAttributes
            [ p
                [ class [ ButtonCss.Label ] ]
                [ text label ]
            ]
