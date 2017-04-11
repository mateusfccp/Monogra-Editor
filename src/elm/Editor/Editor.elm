module Editor exposing (..)

import Editor.Commands as Commands
import Editor.Blocks.Block as Block exposing (Block, BlockID)
import Editor.Blocks.Section as Section
import Editor.Document as Document exposing (Document, DocumentMeta)
import Editor.Messages exposing (Message(..))
import Html exposing (Html, div, hr, p, text)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import RouteUrl exposing (HistoryEntry(..), RouteUrlProgram, UrlChange)


type alias Model =
    { active : BlockID
    , document : WebData Document
    }


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    Just (UrlChange ModifyEntry "/")


location2messages : Location -> List Message
location2messages location =
    []


init : ( Model, Cmd Message )
init =
    ( Model "" RemoteData.Loading, Commands.fetchDocument )


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        OnFetchDocument response ->
            ( { model | document = response }, Cmd.none )

        LoadDocument ->
            init

        SaveDocument ->
            init


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


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
concatAuthors c list =
    list |> List.intersperse c |> List.foldr (++) ""


main : RouteUrlProgram Never Model Message
main =
    RouteUrl.program
        { delta2url = delta2url
        , location2messages = location2messages
        , init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
