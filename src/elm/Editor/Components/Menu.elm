module Editor.Components.Menu exposing (..)

import Editor.Messages exposing (..)
import Editor.Models as Models exposing (EditorModel, MenuStatus(..))
import Html exposing (Html, div, i, text, textarea)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


html : EditorModel -> Html Message
html model =
    let
        ( open, icon ) =
            case model.menu of
                Models.Open ->
                    ( "open", "up" )

                Closed ->
                    ( "closed", "down" )
    in
        div [ class ("menu" ++ " " ++ open) ]
            [ text "Lorem Ipsum Dolor Sit Amet"
            , div [ class "switcher", onClick (Editor (Menu Switch)) ]
                [ i [ class ("fa fa-chevron-" ++ icon ++ " fa-fw") ] []
                ]
            ]
