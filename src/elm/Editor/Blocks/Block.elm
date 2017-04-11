module Editor.Blocks.Block exposing (..)

import Html exposing (Html)
import Editor.Blocks.Paragraph as Paragraph exposing (ParagraphType)
import Editor.Blocks.Section as Section exposing (SectionType)
import Editor.Blocks.Subsection as Subsection
import Json.Decode as Decode exposing (andThen, Decoder, fail, field, list, string)
import Json.Decode.Pipeline exposing (decode, required, custom)


-- Block


type alias Block =
    { id : BlockID
    , blockType : BlockType
    }


type BlockType
    = Paragraph ParagraphType ParagraphContent
    | Section SectionType BlockChildren
    | Subsection SubsectionHeading BlockChildren


type alias BlockID =
    String


type alias BlockChildren =
    List Block



-- Paragraph


type alias ParagraphContent =
    String


paragraphDecoder : Decoder BlockType
paragraphDecoder =
    decode Paragraph
        |> custom (field "ParagraphType" string |> andThen paragraphTypeDecoder)
        |> required "ParagraphContent" string


paragraphTypeDecoder : String -> Decoder ParagraphType
paragraphTypeDecoder paragraphType =
    case paragraphType of
        "Paragraph" ->
            decode Paragraph.Paragraph

        "Quote" ->
            decode Paragraph.Quote

        _ ->
            fail (paragraphType ++ " is not a recognized ParagraphType")



-- Section


sectionDecoder : Decoder BlockType
sectionDecoder =
    decode Section
        |> custom (field "SectionType" string |> andThen sectionTypeDecoder)
        |> required "BlockChildren" (list decoder)


sectionTypeDecoder : String -> Decoder SectionType
sectionTypeDecoder sectionType =
    case sectionType of
        "Cover" ->
            decode Section.Cover

        "Index" ->
            decode Section.Index

        "Body" ->
            decode Section.Body

        "Bibliography" ->
            decode Section.Bibliography

        _ ->
            fail (sectionType ++ " is not a recognized SectionType")



-- Subsection


type alias SubsectionHeading =
    String


subsectionDecoder : Decoder BlockType
subsectionDecoder =
    decode Subsection
        |> required "SubsectionHeading" string
        |> required "BlockChildren" (list decoder)


view : Block -> Html msg
view block =
    case block.blockType of
        Paragraph paragraphType content ->
            Paragraph.html content

        Section sectionType children ->
            Section.html sectionType (List.map view children)

        Subsection heading children ->
            Subsection.html heading (List.map view children)


decoder : Decoder Block
decoder =
    decode Block
        |> required "id" string
        |> custom (field "blocktype" string |> andThen blockDecoder)


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
