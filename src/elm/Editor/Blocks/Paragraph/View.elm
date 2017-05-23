module Editor.Blocks.Paragraph.View exposing (..)

import Editor.Messages exposing (..)
import Html exposing (Html, div, text, textarea)


class : Bool -> List ( String, Bool )
class active =
    [ ( "paragraph", True )
    , ( "active", active )
    ]


events : List (Html.Attribute Message)
events =
    []


headerText : String
headerText =
    "Paragraph"


html : String -> List (Html Message)
html content =
    [ textarea [] [ text content ] ]
