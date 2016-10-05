module InputForm exposing (Msg(PhoenixMessage), initialModel, Model, update, view)

import Html exposing (..)
import Html.Events exposing (onClick, onInput, on, keyCode)
import Html.Attributes exposing (class, placeholder, value, type')
import Json.Decode as Json
import Phoenix.Socket
import Phoenix.Channel
import Phoenix.Push


type alias Model =
    { newMessage : String
    , messages : List String
    , phxSocket : Phoenix.Socket.Socket Msg
    }


initialModel : Model
initialModel =
    { newMessage = ""
    , messages = []
    , phxSocket = initPhoenixSocket
    }


initPhoenixSocket : Phoenix.Socket.Socket Msg
initPhoenixSocket =
    Phoenix.Socket.init socketServerUrl
        |> Phoenix.Socket.withDebug


socketServerUrl : String
socketServerUrl =
    "ws://localhost:4000/socket/websocket"


type Msg
    = SetNewMessage String
    | SaveMessage
    | KeyPress Int
    | JoinChannel
    | PhoenixMessage (Phoenix.Socket.Msg Msg)


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

        JoinChannel ->
            let
                channel =
                    Phoenix.Channel.init "room:lobby"

                ( phxSocket, phxCmd ) =
                    Phoenix.Socket.join channel model.phxSocket
            in
                ( { model
                    | phxSocket = phxSocket
                  }
                , Cmd.map PhoenixMessage phxCmd
                )

        PhoenixMessage msg ->
            let
                ( phxSocket, phxCmd ) =
                    Phoenix.Socket.update msg model.phxSocket
            in
                ( { model
                    | phxSocket = phxSocket
                  }
                , Cmd.map PhoenixMessage phxCmd
                )


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
        , div
            [ class "join-channel-container" ]
            [ button
                [ onClick JoinChannel ]
                [ text "Click to join :D" ]
            ]
        ]


onKeyUp : (Int -> msg) -> Attribute msg
onKeyUp tagger =
    on "keyup" (Json.map tagger keyCode)


renderMessage : String -> Html Msg
renderMessage message =
    li
        [ class "message" ]
        [ Html.text message ]
