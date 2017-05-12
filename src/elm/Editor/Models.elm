module Editor.Models exposing (..)

import RemoteData exposing (WebData)


-- Editor (Main)


type alias Model =
    { active : BlockID
    , document : WebData Document
    }


initialModel : Model
initialModel =
    Model "" RemoteData.Loading



-- Document


type alias Document =
    { meta : DocumentMeta
    , structure : BlockTree
    }


type alias DocumentMeta =
    { abstract : String
    , authors : List String
    , keywords : List String
    , title : String
    }



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
    | Subsection SubsectionHeading


type alias BlockID =
    String


type BlockChildren
    = Some (List BlockNode)
    | None



-- Paragraph


type ParagraphType
    = DefaultParagraph
    | Quote


type alias ParagraphContent =
    String



-- Section


type SectionType
    = Cover
    | Index
    | Body
    | Bibliography


type alias SubsectionHeading =
    String
