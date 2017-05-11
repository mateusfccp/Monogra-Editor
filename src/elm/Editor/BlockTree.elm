module BlockTree exposing (..)

import Editor.Models exposing (Block)
import List exposing (filterMap, head)


type alias BlockID =
    String


type BlockChildren
    = Some (List BlockNode)
    | None


type alias BlockTree =
    BlockNode


type alias BlockNode =
    { name : BlockID
    , value : Block
    , children : BlockChildren
    }


get : BlockTree -> BlockID -> Maybe Block
get tree name_ =
    if tree.name == name_ then
        Just tree.value
    else
        case tree.children of
            Some children ->
                head (filterMap (\element -> get element name_) children)

            None ->
                Nothing
