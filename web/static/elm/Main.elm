module Main exposing (..)
import Html exposing (text, div, h1)
import Html.Attributes exposing (class)

main =
  div
    [ class "jumbotron" ]
    [ h1 [] [ text "Welcom to Elm!" ] ]
