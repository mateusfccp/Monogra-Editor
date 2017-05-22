module Editor.Document exposing (..)

import Editor.Messages exposing (..)
import Editor.Blocks.Block as Block
import Editor.Blocks.Model exposing (..)
import Editor.Document.Model exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (class)


html : Document -> BlockID -> Html Message
html document active =
    Block.view document.structure active
