module Editor.Blocks.Model exposing (..)

import Editor.Blocks.Paragraph.Model exposing (..)
import Editor.Blocks.Section.Model exposing (..)
import Editor.Blocks.Subsection.Model exposing (..)


-- BlockTree


type alias BlockTree =
    BlockNode


type alias BlockNode =
    { id : BlockID
    , value : Block
    , children : BlockChildren
    }



-- Block


type Block
    = Paragraph ParagraphType ParagraphContent
    | Root
    | Section SectionType
    | Subsection SubsectionHeader


type alias BlockID =
    String


type BlockChildren
    = Some (List BlockNode)
    | None
