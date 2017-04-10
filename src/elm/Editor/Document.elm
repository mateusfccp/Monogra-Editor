module Editor.Document exposing (..)

import Editor.Blocks.Block as Block exposing (Block)
import Html exposing (Html, div)
import Html.Attributes exposing (property)
import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Json.Encode as Encode


type alias Document =
    { meta : DocumentMeta
    , structure : List Block
    }


type alias DocumentMeta =
    { abstract : String
    , authors : List String
    , keywords : List String
    , title : String
    }


type alias DocumentStructure =
    List Block


html : List Block -> Html msg
html structure =
    div [ property "className" (Encode.string "p2 bg-white border rounded") ]
        (List.map Block.view structure)


metaDecoder : Decoder DocumentMeta
metaDecoder =
    decode DocumentMeta
        |> required "abstract" string
        |> required "authors" (list string)
        |> required "keywords" (list string)
        |> required "title" string


structureDecoder : Decoder DocumentStructure
structureDecoder =
    list Block.decoder


documentDecoder : Decoder Document
documentDecoder =
    decode Document
        |> required "meta" metaDecoder
        |> required "structure" structureDecoder
