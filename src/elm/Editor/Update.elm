module Editor.Update exposing (..)

import Editor.Messages exposing (Message(..))
import Editor.Models exposing (..)


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        OnFetchDocument response ->
            ( { model | document = response }, Cmd.none )

        LoadDocument ->
            model ! []

        SaveDocument ->
            model ! []
