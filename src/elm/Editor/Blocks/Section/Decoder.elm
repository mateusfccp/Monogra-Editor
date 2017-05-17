module Editor.Blocks.Section.Decoder exposing (..)

import Editor.Blocks.Model exposing (..)
import Editor.Blocks.Section.Model exposing (..)
import Json.Decode as Decode exposing (andThen, Decoder, fail, field, string)
import Json.Decode.Pipeline exposing (decode, custom)


sectionDecoder : Decoder Block
sectionDecoder =
    decode Section
        |> custom (field "SectionType" string |> andThen sectionTypeDecoder)


sectionTypeDecoder : String -> Decoder SectionType
sectionTypeDecoder sectionType =
    case sectionType of
        "Cover" ->
            decode Cover

        "Index" ->
            decode Index

        "Body" ->
            decode Body

        "Bibliography" ->
            decode Bibliography

        _ ->
            fail (sectionType ++ " is not a recognized SectionType")
