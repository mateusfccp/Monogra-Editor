module Editor.Blocks.Block exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Editor.Blocks.Paragraph as Paragraph
import Editor.Blocks.Section as Section
import Editor.Blocks.Subsection as Subsection
import Editor.Models exposing (..)
import Json.Decode as Decode exposing (andThen, Decoder, fail, field, lazy, list, maybe, string)
import Json.Decode.Pipeline exposing (decode, optional, required, custom)


-- Paragraph


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
            decode Quote

        _ ->
            fail (paragraphType ++ " is not a recognized ParagraphType")



-- Section


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



-- Subsection


subsectionDecoder : Decoder Block
subsectionDecoder =
    decode Subsection
        |> required "SubsectionHeading" string



-- Block


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



-- |> optional "Children" (list (lazy (\_ -> decoder)))


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


view : BlockNode -> Html msg
view block =
    let
        inner =
            case block.value of
                Paragraph paragraphType content ->
                    Paragraph.html content

                Root ->
                    div [] (parseChildren block.children)

                Section sectionType ->
                    Section.html sectionType (parseChildren block.children)

                Subsection heading ->
                    Subsection.html heading (parseChildren block.children)
    in
        div [ class "block" ] [ inner ]


parseChildren : BlockChildren -> List (Html msg)
parseChildren children =
    case children of
        Some children ->
            List.map view children

        None ->
            []
