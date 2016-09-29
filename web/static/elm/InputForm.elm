module InputForm exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput, on, keyCode)
import Html.Attributes exposing (placeholder, value, type')
import Json.Decode as Json
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


{ id, class, classList } =
    withNamespace "input-form"
type CssClasses
    = Container


type alias Model =
    { newMessage : String
    , messages : List String
    }


initialModel : Model
initialModel =
    { newMessage = ""
    , messages = []
    }


type Msg
    = SetNewMessage String
    | SaveMessage
    | KeyPress Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetNewMessage messageToShow ->
            ( { model | newMessage = messageToShow }
            , Cmd.none
            )

        SaveMessage ->
            ( { model
                | messages = List.append model.messages [ model.newMessage ]
                , newMessage = ""
              }
            , Cmd.none
            )

        KeyPress 13 ->
            ( { model
                | messages = List.append model.messages [ model.newMessage ]
                , newMessage = ""
              }
            , Cmd.none
            )

        KeyPress _ ->
            ( model, Cmd.none )


css : Css.Stylesheet
css =
    (stylesheet << namespace "input-form")
        [ (.) Container
            [ backgroundColor (rgb 255 70 10)
            , padding (Css.em 1)
            ]
        ]



-- let
--     nameSpacedSnippets =
--         namespace containerNamespace.name
--             [ (#) Container
--                 [ backgroundColor (rgb 255 70 10) ]
--             ]
-- in
--     stylesheet nameSpacedSnippets


view : Model -> Html Msg
view model =
    let
        compiled =
            compile [ css ]
    in
        div
            [ class [ Container ] ]
            [ node "style" [ type' "text/css" ] [ Html.text compiled.css ]
            , ul
                [ class [ "messages" ] ]
                (List.map renderMessage model.messages)
            , input
                [ placeholder "Type message..."
                , onInput SetNewMessage
                , onKeyUp KeyPress
                , value model.newMessage
                ]
                []
            , button
                [ onClick SaveMessage ]
                [ Html.text "Send Message" ]
            ]


onKeyUp : (Int -> msg) -> Attribute msg
onKeyUp tagger =
    on "keyup" (Json.map tagger keyCode)


renderMessage : String -> Html Msg
renderMessage message =
    li
        [ class [ "message" ] ]
        [ Html.text message ]
