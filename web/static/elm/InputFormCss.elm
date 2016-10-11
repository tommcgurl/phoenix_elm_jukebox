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


css =
    (stylesheet << namespace inputFormNamespace.name)
        [ (.) JoinChannelFormContainer
            [ displayFlex
            , padding (px 10)
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
                    , borderRadius (px 3)
                    , color (hex "#ffffff")
                    , backgroundColor (hex "#00B9B8")
                    ]
                ]
            ]
        , (.) MessageFormContainer
            [ displayFlex
            , flexDirection column
            , padding2 (pct 20) (px 20)
            , children
                [ input
                    [ marginBottom (px 20)
                    , flex (int 1)
                    , height (px 42)
                    , border2 (px 1) solid
                    , borderColor (hex "#cccccc")
                    , borderRadius (px 3)
                    , padding (px 8)
                    ]
                , button
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
        ]
