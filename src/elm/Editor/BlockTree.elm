module BlockTree exposing (..)

import Editor.Blocks.Model exposing (..)
import List exposing (filterMap, head)


get : BlockTree -> BlockID -> Maybe Block
get tree id =
    if tree.id == id then
        Just tree.value
    else
        case tree.children of
            Some children ->
                head (filterMap (\element -> get element id) children)

            None ->
                Nothing
