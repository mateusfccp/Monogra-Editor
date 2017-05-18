module Editor.Update exposing (..)

import Editor.Messages exposing (..)
import Editor.Blocks.Model exposing (BlockID)
import Editor.Components.Menu.Messages exposing (..)
import Editor.Document.Messages exposing (..)
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

        Document msg ->
            updateDocument msg model

        Editor msg ->
            updateEditor msg model


updateEditor : EditorMessage -> Model -> ( Model, Cmd Message )
updateEditor msg model =
    case msg of
        Activate id ->
            setBlock model id

        Menu message ->
            updateMenu message model


setBlock : Model -> BlockID -> ( Model, Cmd Message )
setBlock model id =
    let
        editor =
            model.editor
    in
        ( { model | editor = { editor | active = id } }, Cmd.none )
