module Editor.Blocks.Paragraph.Decoder exposing (..)

import Editor.Blocks.Model exposing (..)
import Editor.Blocks.Paragraph.Model exposing (..)
import Json.Decode as Decode exposing (andThen, Decoder, fail, field, string)
import Json.Decode.Pipeline exposing (decode, required, custom)


paragraphDecoder : Decoder Block
paragraphDecoder =
    decode Paragraph
        |> custom (field "ParagraphType" string |> andThen paragraphTypeDecoder)
        |> required "ParagraphContent" string


paragraphTypeDecoder : String -> Decoder ParagraphType
paragraphTypeDecoder paragraphType =
    case paragraphType of
        "Default" ->
            decode DefaultParagraph

        "Quote" ->
            decode QuoteParagraph

        _ ->
            fail (paragraphType ++ " is not a recognized ParagraphType")
