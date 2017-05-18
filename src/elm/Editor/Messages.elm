module Editor.Messages exposing (..)

import Editor.Components.Menu.Messages exposing (MenuMessage)
import Editor.Blocks.Model exposing (BlockID)
import Editor.Document.Messages exposing (..)
import Editor.Document.Model exposing (Document)
import RemoteData exposing (WebData)


type Message
    = OnFetchDocument (WebData Document)
    | LoadDocument
    | SaveDocument
    | Document DocumentMessage
    | Editor EditorMessage


type EditorMessage
    = Activate BlockID
    | Menu MenuMessage
