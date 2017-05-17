module Editor.Commands exposing (..)

import Editor.Document.Decoder as Document
import Editor.Messages as Messages exposing (Message)


-- import Editor.Models exposing (Document)

import Http
import RemoteData


fetchDocument : Cmd Message
fetchDocument =
    Http.get "http://localhost:4000/api/db" Document.decoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchDocument
