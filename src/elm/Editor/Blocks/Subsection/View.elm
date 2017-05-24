module Editor.Blocks.Subsection.View exposing (..)

import Html exposing (Html)


class : List ( String, Bool )
class =
    [ ( "subsection", True )
    ]


events : List (Html.Attribute msg)
events =
    []


header : String -> String
header title =
    title


html : List (Html msg) -> List (Html msg)
html children =
    children
