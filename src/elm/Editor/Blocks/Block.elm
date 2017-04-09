module Editor.Blocks.Block exposing (..)

import Html exposing (Html)
import Editor.Blocks.IndirectQuote as IndirectQuote
import Editor.Blocks.Paragraph as Paragraph
import Editor.Blocks.Section as Section exposing (SectionType)
import Editor.Blocks.Subsection as Subsection


-- Block


type Block
    = IndirectQuote ParagraphContent
    | Paragraph ParagraphContent
    | Section SectionType BlockChildren
    | Subsection SubsectionHeading BlockChildren


type alias BlockChildren =
    List Block



-- Paragraph


type alias ParagraphID =
    String


type alias ParagraphContent =
    String



-- Subsection


type alias SubsectionHeading =
    String


view : Block -> Html msg
view block =
    case block of
        IndirectQuote content ->
            IndirectQuote.html

        Paragraph content ->
            Paragraph.html content

        Section sectiontype children ->
            Section.html sectiontype (List.map view children)

        Subsection heading children ->
            Subsection.html heading (List.map view children)
