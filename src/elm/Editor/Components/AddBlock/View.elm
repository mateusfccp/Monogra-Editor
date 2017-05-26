module Editor.Components.AddBlock.View exposing (..)

import Editor.Blocks.Model exposing (..)
import Editor.Blocks.Paragraph.Model exposing (..)
import Editor.BlockTree as BlockTree
import Editor.Document.Messages exposing (..)
import Editor.Messages exposing (..)
import Html exposing (Html, div, i, input, text, textarea)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (onClick)


html : BlockID -> Html Message
html after =
    div [ class "addBlock", onClick (addBlock after) ]
        [ i [ class "fa fa-plus fa-fw" ] []
        ]


addBlock : BlockID -> Message
addBlock id =
    Document (Structure (AddBlock id (BlockTree.empty (id ++ "_") (Paragraph DefaultParagraph ""))))
