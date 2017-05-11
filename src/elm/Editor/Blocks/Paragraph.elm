module Editor.Blocks.Paragraph exposing (..)

import Html exposing (Html, div, text, textarea)
import Html.Attributes exposing (class)


html : String -> Html msg
html content =
    div []
        [ textarea [ class "fill p2 border rounded" ] [ text content ]
        ]
