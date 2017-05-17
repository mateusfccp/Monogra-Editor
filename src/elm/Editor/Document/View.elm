module Editor.Document exposing (..)

import Editor.Blocks.Block as Block
import Editor.Blocks.Model exposing (..)
import Editor.Document.Model exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (class)


html : BlockTree -> Html msg
html structure =
    div [ class "document" ]
        [ (Block.view structure) ]
