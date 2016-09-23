module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Events exposing (onClick, onInput, keyPress)
import Html.Attributes exposing (class, placeholder, value)


type alias Model =
  { newMessage: String
  , messages: List String
  }

initialModel : Model
initialModel =
  { newMessage = ""
  , messages = []
  }

type Msg
  = SetNewMessage String
  | SaveMessage

update : Msg -> Model -> (Model, Cmd Msg)
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

view : Model -> Html Msg
view model =
  div
    [ class "container" ]
    [ ul
        [ class "Messages" ]
        (List.map renderMessage model.messages)
    , input
        [ placeholder "Type message..."
        , onInput SetNewMessage
        , onKeyPress (\val -> Debug.log val)
        , value model.newMessage
        ]
        []
    , button
        [ onClick SaveMessage ]
        [ text "Send Message" ]
    ]

renderMessage : String -> Html Msg
renderMessage message =
  li
    [ class "message" ]
    [ text message ]

init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )

main =
    App.program
      { init = init
      , update = update
      , view = view
      , subscriptions = subscriptions
      }

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
