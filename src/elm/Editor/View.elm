module Editor.View exposing (..)

import Editor.Document as Document
import Editor.Messages exposing (Message(..))
import Editor.Models exposing (Model)
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
            div []
                [ p [] [ text ("Editando " ++ document.meta.title) ]
                , p [] [ text ("Autor(es): " ++ concatAuthors ", " document.meta.authors) ]
                , hr [] []
                , Document.html document.structure
                ]

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


failureEditorView : Html Message
failureEditorView =
    div [ class "editor failure" ]
        [ div []
            [ i [ class "fa fa-exclamation-triangle fa-5x fa-fw" ] []
            , p [] [ text "Could not load your document!" ]
            ]
        ]
