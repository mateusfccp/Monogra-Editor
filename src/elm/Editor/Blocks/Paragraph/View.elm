module Editor.Blocks.Paragraph.View exposing (..)

import Editor.Messages exposing (..)
import Editor.Document.Messages exposing (..)
import Html exposing (Html, div, text, textarea)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


html : String -> Bool -> Html Message
html content active =
    let
        activeClass =
            if active == True then
                " active"
            else
                ""
    in
        div [ class ("block paragraph" ++ activeClass), onClick (Document (Structure (DeleteBlock "cover"))) ]
            [ textarea [] [ text content ]
            ]
