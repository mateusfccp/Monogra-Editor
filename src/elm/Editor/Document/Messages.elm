module Editor.Document.Messages exposing (..)

import Editor.Models exposing (..)
import Editor.Blocks.Model exposing (BlockID, BlockNode)
import Editor.BlockTree exposing (..)
import Editor.Document.Model as Document exposing (..)
import RemoteData exposing (WebData)


type DocumentMessage
    = Meta MetaMessage
    | Structure StructureMessage


type MetaMessage
    = SetMeta MetaSetMessage


type MetaSetMessage
    = Abstract String
    | Authors (List String)
    | Keywords (List String)
    | Title String


type StructureMessage
    = AddBlock BlockID BlockNode
    | DeleteBlock BlockID
    | SetBlock BlockID BlockNode


updateDocument : DocumentMessage -> Model -> ( Model, Cmd msg )
updateDocument msg model =
    let
        document =
            model.document
    in
        case msg of
            Meta msg ->
                updateMeta msg model

            Structure msg ->
                updateStructure msg model


updateMeta : MetaMessage -> Model -> ( Model, Cmd msg )
updateMeta msg model =
    case msg of
        SetMeta msg ->
            updateMetaSet msg model


updateMetaSet : MetaSetMessage -> Model -> ( Model, Cmd msg )
updateMetaSet msg model =
    let
        document =
            case model.document of
                RemoteData.Success document ->
                    document

                _ ->
                    Document.empty

        meta =
            document.meta
    in
        case msg of
            Abstract value ->
                ( { model | document = RemoteData.Success ({ document | meta = { meta | abstract = value } }) }, Cmd.none )

            Authors value ->
                ( { model | document = RemoteData.Success ({ document | meta = { meta | authors = value } }) }, Cmd.none )

            Keywords value ->
                ( { model | document = RemoteData.Success ({ document | meta = { meta | keywords = value } }) }, Cmd.none )

            Title value ->
                ( { model | document = RemoteData.Success ({ document | meta = { meta | title = value } }) }, Cmd.none )


updateStructure : StructureMessage -> Model -> ( Model, Cmd msg )
updateStructure msg model =
    let
        document =
            case model.document of
                RemoteData.Success document ->
                    document

                _ ->
                    Document.empty

        structure =
            document.structure
    in
        case msg of
            DeleteBlock id ->
                ( { model | document = RemoteData.Success ({ document | structure = structure |> removeChild id }) }, Cmd.none )

            AddBlock id node ->
                ( { model | document = RemoteData.Success ({ document | structure = structure |> addAfter id node }) }, Cmd.none )

            _ ->
                model ! []
