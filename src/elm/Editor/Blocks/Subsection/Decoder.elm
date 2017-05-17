module Editor.Blocks.Subsection.Decoder exposing (..)

import Editor.Blocks.Model exposing (..)
import Json.Decode as Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (decode, required)


subsectionDecoder : Decoder Block
subsectionDecoder =
    decode Subsection
        |> required "SubsectionHeading" string
