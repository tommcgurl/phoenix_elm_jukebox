module Input exposing (..)

import InputCss
import Html exposing (..)


type alias Label =
    String


view attributes label =
    let
        { class } =
            InputCss.inputNamespace

        newAttributes =
            List.append attributes [ class [ InputCss.Container ] ]
    in
        input
            newAttributes
            []
