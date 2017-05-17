module Editor.Components.Menu exposing (..)

import Editor.Components.Menu.Messages as Message exposing (..)
import Editor.Components.Menu.Model as Model exposing (..)
import Editor.Document.Model exposing (..)
import Editor.Models exposing (..)
import Editor.Messages exposing (..)
import Html exposing (Html, div, i, input, text, textarea)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (onClick)


html : Model -> Document -> Html Message
html model document =
    let
        open =
            case model.editor.menu of
                Model.Open ->
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
                Model.Open ->
                    "up"

                Closed ->
                    "down"
    in
        div [ class "switcher", onClick (Editor (Menu Switch)) ]
            [ i [ class ("fa fa-chevron-" ++ icon ++ " fa-fw") ] []
            ]
