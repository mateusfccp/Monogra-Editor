module Editor.View exposing (..)

import Editor.Components.Menu as Menu
import Editor.Document as Document
import Editor.Messages exposing (Message(..))
import Editor.Document.Model exposing (..)
import Editor.Models exposing (..)
import Html exposing (Html, div, hr, i, p, text)
import Html.Attributes exposing (class)
import RemoteData


view : Model -> Html Message
view model =
    case model.document of
        RemoteData.NotAsked ->
            text "There's no document!"

        RemoteData.Loading ->
            loadingEditorView

        RemoteData.Success document ->
            mainEditorView document model

        RemoteData.Failure error ->
            failureEditorView


concatAuthors : String -> List String -> String
concatAuthors char list =
    list
        |> List.intersperse char
        |> List.foldr (++) ""


loadingEditorView : Html Message
loadingEditorView =
    div [ class "editor loading" ]
        [ div []
            [ i [ class "fa fa-cog fa-spin fa-5x fa-fw" ] []
            , p [] [ text "Loading" ]
            ]
        ]


mainEditorView : Document -> Model -> Html Message
mainEditorView document model =
    div [ class "editor main" ]
        [ Menu.html model document
        , Document.html document model.editor.active
        ]


failureEditorView : Html Message
failureEditorView =
    div [ class "editor failure" ]
        [ div []
            [ i [ class "fa fa-exclamation-triangle fa-5x fa-fw" ] []
            , p [] [ text "Could not load your document!" ]
            ]
        ]
