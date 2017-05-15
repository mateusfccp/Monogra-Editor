module Editor.Document exposing (..)

import Editor.Blocks.Block as Block
import Editor.Models exposing (BlockTree, Document, DocumentMeta)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)


html : BlockTree -> Html msg
html structure =
    div [ class "document" ]
        [ (Block.view structure) ]


metaDecoder : Decoder DocumentMeta
metaDecoder =
    decode DocumentMeta
        |> required "abstract" string
        |> required "authors" (list string)
        |> required "keywords" (list string)
        |> required "title" string


decoder : Decoder Document
decoder =
    decode Document
        |> required "meta" metaDecoder
        |> required "structure" Block.decoder
