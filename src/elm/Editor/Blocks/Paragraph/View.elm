module Editor.Blocks.Paragraph.View exposing (..)

import Html exposing (Html, div, text, textarea)
import Html.Attributes exposing (class)


html : String -> Bool -> Html msg
html content active =
    let
        activeClass =
            if active == True then
                " active"
            else
                ""
    in
        div [ class ("block paragraph" ++ activeClass) ]
            [ textarea [] [ text content ]
            ]
