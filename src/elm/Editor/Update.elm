module Editor.Update exposing (..)

import Editor.Messages exposing (..)
import Editor.Components.Menu.Messages exposing (..)
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
