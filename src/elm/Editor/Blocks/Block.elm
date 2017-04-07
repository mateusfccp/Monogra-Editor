module Editor.Blocks.Block exposing (..)

import Html exposing (Html)
import Editor.Blocks.IndirectQuote as IndirectQuote exposing (html)
import Editor.Blocks.Paragraph as Paragraph exposing (html)
import Editor.Blocks.Section as Section exposing (html)
import Editor.Blocks.Subsection as Subsection exposing (html)


-- Block


type Block
    = IndirectQuote ParagraphContent
    | Paragraph ParagraphID ParagraphContent
    | Section SectionType SectionChildren
    | Subsection SubsectionHeading SubsectionChildren



-- Paragraph


type alias ParagraphID =
    String


type alias ParagraphContent =
    String



-- Section


type SectionType
    = Cover
    | Index
    | Body
    | References


type SectionChildren
    = Maybe (List Block)



-- Subsection


type alias SubsectionHeading =
    String


type alias SubsectionChildren =
    List Block


view : Block -> Html msg
view block =
    case block of
        IndirectQuote content ->
            IndirectQuote.html

        Paragraph id content ->
            Paragraph.html

        Section stype children ->
            Section.html

        Subsection heading children ->
            Subsection.html
