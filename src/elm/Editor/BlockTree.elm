module Editor.BlockTree exposing (..)

import Editor.Blocks.Model exposing (..)
import List exposing (filter, filterMap, head, isEmpty, map, tail)


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


addAfter : BlockID -> BlockNode -> BlockTree -> BlockTree
addAfter id node tree =
    let
        inserter =
            (\list ->
                case list of
                    [] ->
                        []

                    first :: rest ->
                        if first.id == id then
                            first :: node :: rest
                        else
                            case first.children of
                                None ->
                                    first :: (inserter rest)

                                Some children ->
                                    { first | children = Some (inserter children) } :: rest
            )
    in
        case get id tree of
            Just _ ->
                case tree.children of
                    Some children ->
                        { tree | children = Some (children |> inserter) }

                    None ->
                        tree

            Nothing ->
                tree


empty : BlockID -> Block -> BlockNode
empty id type_ =
    BlockNode id type_ None
