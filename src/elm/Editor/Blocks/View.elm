module Editor.Blocks.View exposing (..)

import Editor.Messages exposing (..)
import Editor.Document.Messages exposing (..)
import Editor.Blocks.Model exposing (..)
import Editor.Blocks.Paragraph.View as Paragraph
import Editor.Blocks.Section.View as Section
import Editor.Blocks.Subsection.View as Subsection
import List exposing (map)
import Html exposing (Html, div, i, p, text)
import Html.Attributes exposing (attribute, class, classList)
import Html.Events exposing (onClick)


type alias BlockData =
    { classList : List ( String, Bool )
    , header : String
    , html : List (Html Message)
    }


view : BlockNode -> BlockID -> Html Message
view block active =
    let
        html =
            case block.value of
                Root ->
                    div [ class "document" ]
                        (parseChildren block.children active)

                _ ->
                    parseBlock block active
    in
        html


parseBlock : BlockNode -> BlockID -> Html Message
parseBlock block active =
    let
        blockData =
            case block.value of
                Paragraph type_ content ->
                    BlockData Paragraph.class Paragraph.header (Paragraph.html content)

                Subsection title ->
                    BlockData Subsection.class (Subsection.header title) (Subsection.html (parseChildren block.children active))

                Section type_ ->
                    BlockData (Section.class type_) (Section.header type_) (Section.html type_ (parseChildren block.children active))

                _ ->
                    BlockData [] "" []

        classList_ =
            classList
                ([ ( "block", True )
                 , ( "active", (block.id == active) )
                 ]
                    ++ blockData.classList
                )
    in
        div [ attribute "data-id" block.id, classList_ ]
            ([ div [ class "header" ]
                [ p [] [ text blockData.header ]
                , div
                    [ class "close-button" ]
                    [ i [ class "fa fa-times fa-fw", onClick (deleteBlock block.id) ] [] ]
                ]
             ]
                ++ blockData.html
            )


parseChildren : BlockChildren -> BlockID -> List (Html Message)
parseChildren children active =
    let
        view_ =
            (\child -> view child active)
    in
        case children of
            Some children ->
                children |> map view_

            None ->
                []


deleteBlock : BlockID -> Message
deleteBlock id =
    (Document (Structure (DeleteBlock id)))
