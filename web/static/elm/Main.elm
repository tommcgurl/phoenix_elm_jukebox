module Main exposing (..)

import Html as Html
import InputForm
import ChatMessage exposing (ChatMessage)
import Phoenix.Socket


type alias Flags =
    { messages : List ChatMessage
    }


init : Flags -> ( InputForm.Model, Cmd InputForm.Msg )
init flags =
    ( InputForm.initialModel flags.messages, Cmd.none )


main =
    Html.programWithFlags
        { init = init
        , update = InputForm.update
        , view = InputForm.view
        , subscriptions = subscriptions
        }


subscriptions : InputForm.Model -> Sub InputForm.Msg
subscriptions model =
    Phoenix.Socket.listen model.phxSocket (InputForm.PhoenixMessage)
