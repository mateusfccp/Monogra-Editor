module Editor.Document.Model exposing (..)

import Editor.Blocks.Model exposing (BlockTree, BlockNode, Block(Root), BlockChildren(None))
import RemoteData exposing (WebData)


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


type alias WebDocument =
    WebData Document


empty : Document
empty =
    let
        meta =
            DocumentMeta "" [] [] ""

        block =
            BlockNode "root" Root None

        document =
            Document meta block
    in
        document
