module Editor.Blocks.Block exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Editor.Blocks.Paragraph as Paragraph
import Editor.Blocks.Section as Section
import Editor.Blocks.Subsection as Subsection
import Editor.Models exposing (..)
import Json.Decode as Decode exposing (andThen, Decoder, fail, field, lazy, list, string)
import Json.Decode.Pipeline exposing (decode, required, custom)


-- Paragraph


paragraphDecoder : Decoder BlockType
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
            decode Quote

        _ ->
            fail (paragraphType ++ " is not a recognized ParagraphType")



-- Section


sectionDecoder : Decoder BlockType
sectionDecoder =
    decode Section
        |> custom (field "SectionType" string |> andThen sectionTypeDecoder)
        |> required "BlockChildren" (list (lazy (\_ -> decoder)))


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



-- Subsection


subsectionDecoder : Decoder BlockType
subsectionDecoder =
    decode Subsection
        |> required "SubsectionHeading" string
        |> required "BlockChildren" (list (lazy (\_ -> decoder)))



-- Block


decoder : Decoder Block
decoder =
    decode Block
        |> required "id" string
        |> custom (field "blockType" string |> andThen blockDecoder)


blockDecoder : String -> Decoder BlockType
blockDecoder blockType =
    case blockType of
        "Paragraph" ->
            paragraphDecoder

        "Section" ->
            sectionDecoder

        "Subsection" ->
            subsectionDecoder

        _ ->
            fail (blockType ++ " is not a recognized BlockType")


view : Block -> Html msg
view block =
    let
        inner =
            case block.blockType of
                Paragraph paragraphType content ->
                    Paragraph.html content

                Section sectionType children ->
                    Section.html sectionType (List.map view children)

                Subsection heading children ->
                    Subsection.html heading (List.map view children)
    in
        div [ class "block" ] [ inner ]
