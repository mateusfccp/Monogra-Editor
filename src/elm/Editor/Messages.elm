module Editor.Messages exposing (..)

import Editor.Document.Model exposing (Document)
import Editor.Components.Menu.Messages exposing (MenuMessage)
import RemoteData exposing (WebData)


type Message
    = OnFetchDocument (WebData Document)
    | LoadDocument
    | SaveDocument
    | Editor EditorMessage


type EditorMessage
    = Menu MenuMessage
