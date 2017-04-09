module Editor.Document exposing (..)

import Editor.Blocks.Block as Block exposing (Block)
import Html exposing (Html, div)
import Html.Attributes exposing (property)
import Json.Encode as Encode


type alias Document =
    { meta : DocumentMeta
    , structure : List Block
    }


type alias DocumentMeta =
    { authors : List String
    , keywords : List String
    , title : String
    , abstract : String
    }


html : List Block -> Html msg
html structure =
    div [ property "className" (Encode.string "p2 bg-white border rounded") ]
        (List.map Block.view structure)
