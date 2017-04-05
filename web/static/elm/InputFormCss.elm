module InputFormCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li, input, button)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


inputFormNamespace =
    withNamespace "input-form-"


type CssClasses
    = JoinChannelFormContainer
    | MessageFormContainer
    | JoinChannelInput
    | MessagesContainer
    | Container
    | FormContainer
    | JoinViewContainer


css =
    (stylesheet << namespace inputFormNamespace.name)
        [ class Container
            [ height (pct 100)
            , displayFlex
            , flexDirection column
            , fontFamilies [ "Avenir Next" ]
            ]
        , class FormContainer
            [ height (pct 100)
            , displayFlex
            , flexDirection column
            , justifyContent spaceBetween
            ]
        , class JoinChannelFormContainer
            [ displayFlex
            , flex (int 1)
            , flexDirection column
            , padding (px 10)
            , justifyContent spaceAround
            , children
                [ input
                    [ flex (int 1)
                    , height (px 42)
                    , border2 (px 1) solid
                    , borderColor (hex "#cccccc")
                    , borderRadius (px 3)
                    , padding (px 8)
                    , marginRight (px 8)
                    ]
                , button
                    [ border (px 0)
                    , height (px 42)
                    , borderRadius (px 3)
                    , color (hex "#ffffff")
                    , backgroundColor (hex "#00B9B8")
                    ]
                ]
            ]
        , class MessageFormContainer
            [ displayFlex
            , flexDirection column
            , flex (int 2)
            , padding2 (pct 5) (px 20)
            , children
                [ button
                    [ border (px 0)
                    , height (px 42)
                    , borderRadius (px 3)
                    , color (hex "#ffffff")
                    , backgroundColor (hex "#00B9B8")
                    , hover
                        [ backgroundColor (hex "#008A89")
                        ]
                    ]
                ]
            ]
        , class MessagesContainer
            [ displayFlex
            , borderRadius (px 3)
            , flexDirection column
            , flex (int 5)
            , backgroundColor (rgba 216 216 216 0.22)
            , color (hex "#FFF")
            ]
        , class JoinViewContainer
            [ displayFlex
            , flex (int 1)
            , flexDirection column
            , justifyContent center
            ]
        ]
