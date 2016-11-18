module InputForm exposing (Msg(PhoenixMessage), initialModel, Model, update, view)

import InputFormCss
import Input
import ChatMessage
import Button
import Html exposing (..)
import Html.Events exposing (onClick, onInput, on, keyCode)
import Html.Attributes exposing (class, placeholder, value, type')
import Json.Decode as Json
import Phoenix.Socket
import Phoenix.Channel
import Phoenix.Push
import Json.Encode as JE
import Json.Decode as JD exposing ((:=))


type alias Model =
    { newMessage : String
    , userName : String
    , messages : List ChatMessage.ChatMessage
    , joinedAlert : String
    , hasJoined : Bool
    , phxSocket : Phoenix.Socket.Socket Msg
    }


initialModel : List ChatMessage.ChatMessage -> Model
initialModel initialMessages =
    { newMessage = ""
    , userName = ""
    , joinedAlert = ""
    , hasJoined = False
    , messages = initialMessages
    , phxSocket = initPhoenixSocket
    }


initPhoenixSocket : Phoenix.Socket.Socket Msg
initPhoenixSocket =
    Phoenix.Socket.init socketServerUrl
        |> Phoenix.Socket.withDebug
        |> Phoenix.Socket.on "message:new" "room:lobby" ReceiveMessage
        |> Phoenix.Socket.on "joined:new" "room:lobby" ReceiveJoined


socketServerUrl : String
socketServerUrl =
    "ws://localhost:4000/socket/websocket"


userParams : Model -> JE.Value
userParams model =
    JE.object [ ( "user", (JE.string model.userName) ) ]


type Msg
    = SetNewMessage String
    | SetUserName String
    | SendMessage
    | KeyPressMessageInput Int
      -- Handle user clicking enter on message input
    | KeyPressUserNameInput Int
      -- Handle user clicking enter on userName input
    | JoinChannel
    | PhoenixMessage (Phoenix.Socket.Msg Msg)
    | ReceiveMessage JE.Value
    | ReceiveJoined JE.Value



-- Called by the update function to push a new message
-- to the Phoenix socket.


pushNewMessage : Msg -> Model -> ( Model, Cmd Msg )
pushNewMessage msg model =
    let
        payload =
            (JE.string model.newMessage)

        push' =
            Phoenix.Push.init "message:new" "room:lobby"
                |> Phoenix.Push.withPayload payload

        ( phxSocket, phxCmd ) =
            Phoenix.Socket.push push' model.phxSocket
    in
        ( { model
            | newMessage = ""
            , phxSocket = phxSocket
          }
        , Cmd.map PhoenixMessage phxCmd
        )



-- Called by the update function to join the Phoenix
-- channel.


joinChannel : Msg -> Model -> ( Model, Cmd Msg )
joinChannel msg model =
    let
        channel =
            Phoenix.Channel.init "room:lobby"
                |> Phoenix.Channel.withPayload (userParams model)

        ( phxSocket, phxCmd ) =
            Phoenix.Socket.join channel model.phxSocket
    in
        ( { model
            | phxSocket = phxSocket
          }
        , Cmd.map PhoenixMessage phxCmd
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetNewMessage messageToShow ->
            ( { model | newMessage = messageToShow }
            , Cmd.none
            )

        SetUserName newUserName ->
            ( { model | userName = newUserName }
            , Cmd.none
            )

        SendMessage ->
            pushNewMessage msg model

        KeyPressMessageInput 13 ->
            pushNewMessage msg model

        KeyPressMessageInput _ ->
            ( model, Cmd.none )

        KeyPressUserNameInput 13 ->
            joinChannel msg model

        KeyPressUserNameInput _ ->
            ( model, Cmd.none )

        JoinChannel ->
            joinChannel msg model

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

        ReceiveMessage raw ->
            case JD.decodeValue socketMessageDecoder raw of
                Ok chatMessage ->
                    (Debug.log "Here dat message yo:")
                        ( { model | messages = List.append model.messages [ chatMessage ] }
                        , Cmd.none
                        )

                Err error ->
                    (Debug.log error)
                        ( model, Cmd.none )

        ReceiveJoined raw ->
            case JD.decodeValue socketMessageDecoder raw of
                Ok chatMessage ->
                    let
                        message =
                            if chatMessage.user_name /= model.userName then
                                chatMessage.user_name ++ " " ++ chatMessage.body
                            else
                                "You have joined the lobby!"
                    in
                        ( { model
                            | joinedAlert = message
                            , hasJoined = True
                          }
                        , Cmd.none
                        )

                Err error ->
                    (Debug.log error)
                        ( model, Cmd.none )


socketMessageDecoder : JD.Decoder ChatMessage.ChatMessage
socketMessageDecoder =
    JD.object3 ChatMessage.ChatMessage
        ("body" := JD.string)
        ("user_name" := JD.string)
        ("timestamp" := JD.string)


renderJoinView : Model -> List (Html Msg)
renderJoinView model =
    let
        { class } =
            InputFormCss.inputFormNamespace
    in
        [ div
            [ class [ InputFormCss.JoinViewContainer ] ]
            [ Input.view
                [ placeholder "Enter a username"
                , onInput SetUserName
                , onKeyUp KeyPressUserNameInput
                , value model.userName
                ]
                []
            , Button.view
                [ onClick JoinChannel ]
                "JOIN"
            ]
        ]


renderMessagesView : Model -> List (Html Msg)
renderMessagesView model =
    let
        { class } =
            InputFormCss.inputFormNamespace
    in
        [ div
            [ class [ InputFormCss.MessagesContainer ] ]
            [ ul
                []
                (List.map ChatMessage.view model.messages)
            ]
        , div
            [ class [ InputFormCss.MessageFormContainer ] ]
            [ Input.view
                [ placeholder "Enter a song name"
                , onInput SetNewMessage
                , onKeyUp KeyPressMessageInput
                , value model.newMessage
                ]
                []
            , Button.view
                [ onClick SendMessage ]
                "Cue it up!"
            ]
        ]


renderContent : Model -> List (Html Msg)
renderContent model =
    if model.hasJoined then
        renderMessagesView model
    else
        renderJoinView model


view : Model -> Html Msg
view model =
    let
        { class } =
            InputFormCss.inputFormNamespace
    in
        div
            [ class [ InputFormCss.Container ] ]
            [ renderAlertIfNeeded model
            , div
                [ class [ InputFormCss.FormContainer ] ]
                (renderContent model)
            ]


renderAlertIfNeeded : Model -> Html Msg
renderAlertIfNeeded model =
    let
        { class } =
            InputFormCss.inputFormNamespace
    in
        div
            [ class [ "alert" ]
            , class [ "alert-success" ]
            ]
            [ text model.joinedAlert ]



-- Custom onKeyUp Event


onKeyUp : (Int -> msg) -> Attribute msg
onKeyUp tagger =
    on "keyup" (Json.map tagger keyCode)


renderMessage : String -> Html Msg
renderMessage message =
    let
        { class } =
            InputFormCss.inputFormNamespace
    in
        li
            [ class [ "message" ] ]
            [ Html.text message ]
