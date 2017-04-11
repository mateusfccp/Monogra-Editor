module Editor.Messages exposing (..)

import Editor.Document as Document exposing (Document)
import RemoteData exposing (WebData)


type Message
    = OnFetchDocument (WebData Document)
    | LoadDocument
    | SaveDocument
