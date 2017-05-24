module Editor.Blocks.Paragraph.View exposing (..)

import Html exposing (Html, div, text, textarea)


class : List ( String, Bool )
class =
    [ ( "paragraph", True )
    ]


events : List (Html.Attribute msg)
events =
    []


header : String
header =
    "Parágrafo"


html : String -> List (Html msg)
html content =
    [ textarea [] [ text content ] ]
