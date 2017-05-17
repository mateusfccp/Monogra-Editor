module Editor.Components.Menu.Messages exposing (..)

import Editor.Models exposing (..)
import Editor.Components.Menu.Model as Model exposing (..)


type MenuMessage
    = Open
    | Close
    | Switch


updateMenu : MenuMessage -> Model -> ( Model, Cmd msg )
updateMenu msg model =
    let
        editor =
            model.editor
    in
        case msg of
            Close ->
                ( { model | editor = { editor | menu = Closed } }, Cmd.none )

            Open ->
                ( { model | editor = { editor | menu = Model.Open } }, Cmd.none )

            Switch ->
                case editor.menu of
                    Closed ->
                        updateMenu Open model

                    Model.Open ->
                        updateMenu Close model
