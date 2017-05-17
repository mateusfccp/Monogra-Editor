module Editor.Blocks.Paragraph.View exposing (..)

import Html exposing (Html, div, text, textarea)
import Html.Attributes exposing (class)


html : String -> Html msg
html content =
    div [ class "paragraph" ]
        [ textarea [] [ text content ]
        ]
