module Editor.Blocks.Subsection.View exposing (..)

import Editor.Messages exposing (..)
import Html exposing (Html)


class : Bool -> List ( String, Bool )
class active =
    [ ( "subsection", True )
    , ( "active", active )
    ]


events : List (Html.Attribute Message)
events =
    []


headerText : String
headerText =
    "Section"


html : List (Html msg) -> List (Html msg)
html children =
    children
