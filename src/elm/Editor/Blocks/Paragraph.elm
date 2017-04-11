module Editor.Blocks.Paragraph exposing (..)

import Html exposing (Html, div, text, textarea)
import Html.Attributes exposing (property)
import Json.Encode as Encode


type ParagraphType
    = Paragraph
    | Quote


html : String -> Html msg
html content =
    div []
        [ textarea [ property "className" (Encode.string "fill p2 border rounded") ] [ text content ]
        ]
