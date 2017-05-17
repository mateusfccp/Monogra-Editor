module Editor.Document.Model exposing (..)

import Editor.Blocks.Model exposing (BlockTree)


type alias Document =
    { meta : DocumentMeta
    , structure : BlockTree
    }


type alias DocumentMeta =
    { abstract : String
    , authors : List String
    , keywords : List String
    , title : String
    }
