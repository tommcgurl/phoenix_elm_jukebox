module Main exposing (..)

import Html.App as App
import InputForm
import Phoenix.Socket


init : ( InputForm.Model, Cmd InputForm.Msg )
init =
    ( InputForm.initialModel, Cmd.none )


main =
    App.program
        { init = init
        , update = InputForm.update
        , view = InputForm.view
        , subscriptions = subscriptions
        }


subscriptions : InputForm.Model -> Sub InputForm.Msg
subscriptions model =
    Phoenix.Socket.listen model.phxSocket (InputForm.PhoenixMessage)
