module Editor.Blocks.Paragraph exposing (..)

import Html exposing (Html, div, text, textarea)
import Html.Attributes exposing (property)
import Json.Encode as Encode


html : String -> Html msg
html content =
    div []
        [ textarea [ property "className" (Encode.string "fill p2 border rounded") ] [ text content ]
        ]
