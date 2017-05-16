module Editor.Components.Menu exposing (..)

import Editor.Messages exposing (..)
import Editor.Models as Models exposing (Document, EditorModel, Model, MenuStatus(..))
import Html exposing (Html, div, i, input, text, textarea)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (onClick)


html : Model -> Document -> Html Message
html model document =
    let
        open =
            case model.editor.menu of
                Models.Open ->
                    "open"

                Closed ->
                    "closed"
    in
        div [ class ("menu" ++ " " ++ open) ]
            [ input [ type_ "text", value document.meta.title ] []
            , switcher model.editor
            ]


switcher : EditorModel -> Html Message
switcher model =
    let
        icon =
            case model.menu of
                Models.Open ->
                    "up"

                Closed ->
                    "down"
    in
        div [ class "switcher", onClick (Editor (Menu Switch)) ]
            [ i [ class ("fa fa-chevron-" ++ icon ++ " fa-fw") ] []
            ]
