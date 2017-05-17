module Editor.Blocks.Decoder exposing (..)

import Editor.Blocks.Model exposing (..)
import Editor.Blocks.Paragraph.Decoder exposing (..)
import Editor.Blocks.Section.Decoder exposing (..)
import Editor.Blocks.Subsection.Decoder exposing (..)
import Json.Decode as Decode exposing (andThen, Decoder, fail, field, lazy, list, maybe, string)
import Json.Decode.Pipeline exposing (decode, optional, required, custom)


childrenDecoder : Maybe (List BlockNode) -> Decoder BlockChildren
childrenDecoder children =
    case children of
        Nothing ->
            decode None

        Just value ->
            case value of
                [] ->
                    decode None

                _ ->
                    decode (Some value)


decoder : Decoder BlockNode
decoder =
    decode BlockNode
        |> required "id" string
        |> custom (field "Type" string |> andThen valueDecoder)
        |> custom (maybe (field "Children" (list (lazy (\_ -> decoder)))) |> andThen childrenDecoder)


valueDecoder : String -> Decoder Block
valueDecoder blockType =
    case blockType of
        "Paragraph" ->
            paragraphDecoder

        "Root" ->
            decode Root

        "Section" ->
            sectionDecoder

        "Subsection" ->
            subsectionDecoder

        _ ->
            fail (blockType ++ " is not a recognized BlockType")
