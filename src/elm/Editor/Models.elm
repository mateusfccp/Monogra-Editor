module Editor.Models exposing (..)

import Editor.Blocks.Model exposing (..)
import Editor.Components.Menu.Model exposing (..)
import Editor.Document.Model exposing (..)
import RemoteData exposing (WebData)


type alias Model =
    { document : WebData Document
    , editor : EditorModel
    }


type alias EditorModel =
    { active : BlockID
    , menu : MenuStatus
    }


initialModel : Model
initialModel =
    Model RemoteData.Loading { active = "", menu = Open }
