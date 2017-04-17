module Editor.Messages exposing (..)

import Editor.Models exposing (Document)
import RemoteData exposing (WebData)


type Message
    = OnFetchDocument (WebData Document)
    | LoadDocument
    | SaveDocument
