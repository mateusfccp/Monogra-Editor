module Editor.Document.Decoder exposing (..)

import Editor.Blocks.Decoder as Block exposing (..)
import Editor.Document.Model exposing (..)
import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (decode, required)


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
