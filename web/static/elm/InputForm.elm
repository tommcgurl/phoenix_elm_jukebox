module InputForm exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput, on, keyCode)
import Html.Attributes exposing (class, placeholder, value, type')
import Json.Decode as Json


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


view : Model -> Html Msg
view model =
    div
        [ class "input-form-container" ]
        [ ul
            [ class "messages" ]
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
        [ class "message" ]
        [ Html.text message ]
