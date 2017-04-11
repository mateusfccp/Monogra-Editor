module Editor.Commands exposing (..)

import Editor.Document as Document
import Editor.Messages as Messages exposing (Message)
import Http
import RemoteData


fetchDocument : Cmd Message
fetchDocument =
    Http.get "localhost:4000/db" Document.decoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchDocument
