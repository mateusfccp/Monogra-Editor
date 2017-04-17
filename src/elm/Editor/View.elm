module Editor.View exposing (..)

import Editor.Document as Document
import Editor.Messages exposing (Message(..))
import Editor.Models exposing (Model)
import Html exposing (Html, div, hr, p, text)
import RemoteData


view : Model -> Html Message
view model =
    case model.document of
        RemoteData.NotAsked ->
            text "There's no document!"

        RemoteData.Loading ->
            text "Loading document... please, wait..."

        RemoteData.Success document ->
            div []
                [ p [] [ text ("Editando " ++ document.meta.title) ]
                , p [] [ text ("Autor(es): " ++ concatAuthors ", " document.meta.authors) ]
                , hr [] []
                , Document.html document.structure
                ]

        RemoteData.Failure error ->
            text (toString error)


concatAuthors : String -> List String -> String
concatAuthors char list =
    list
        |> List.intersperse char
        |> List.foldr (++) ""
