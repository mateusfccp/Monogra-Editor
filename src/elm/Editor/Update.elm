module Editor.Update exposing (..)

import Editor.Messages as Messages exposing (..)
import Editor.Models as Models exposing (..)


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        OnFetchDocument response ->
            ( { model | document = response }, Cmd.none )

        LoadDocument ->
            model ! []

        SaveDocument ->
            model ! []

        Editor message ->
            updateEditor message model


updateEditor : EditorMessage -> Model -> ( Model, Cmd Message )
updateEditor msg model =
    case msg of
        Menu message ->
            updateMenu message model


updateMenu : MenuMessage -> Model -> ( Model, Cmd Message )
updateMenu msg model =
    let
        editor =
            model.editor
    in
        case msg of
            Close ->
                ( { model | editor = { editor | menu = Closed } }, Cmd.none )

            Messages.Open ->
                ( { model | editor = { editor | menu = Models.Open } }, Cmd.none )

            Switch ->
                case editor.menu of
                    Closed ->
                        updateMenu Messages.Open model

                    Models.Open ->
                        updateMenu Close model
