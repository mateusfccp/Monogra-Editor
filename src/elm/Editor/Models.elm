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
    , structure : List Block
    }


type alias DocumentMeta =
    { abstract : String
    , authors : List String
    , keywords : List String
    , title : String
    }


type alias DocumentStructure =
    List Block



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
