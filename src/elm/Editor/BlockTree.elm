module Editor.BlockTree exposing (..)

import Editor.Blocks.Model exposing (..)
import List exposing (filter, filterMap, head, map)


get : BlockID -> BlockTree -> Maybe Block
get id tree =
    if tree.id == id then
        Just tree.value
    else
        case tree.children of
            Some children ->
                children |> filterMap (\el -> get id el) |> head

            None ->
                Nothing


removeChild : BlockID -> BlockTree -> BlockTree
removeChild id tree =
    case tree.children of
        Some children_ ->
            { tree | children = Some (children_ |> filter (\child -> child.id /= id) |> map (removeChild id)) }

        None ->
            tree
