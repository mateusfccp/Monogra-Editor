module Editor.Blocks.View exposing (..)

import Html exposing (Html, div, i, p, text)
import Html.Attributes exposing (attribute, class, classList)
import Html.Events as Events
import Editor.Messages exposing (..)
import Editor.Document.Messages exposing (..)
import Editor.Blocks.Model exposing (..)
import Editor.Blocks.Paragraph.View as Paragraph
import Editor.Blocks.Section.View as Section
import Editor.Blocks.Subsection.View as Subsection
import Json.Decode as Json


view : BlockNode -> BlockID -> Html Message
view block active =
    let
        classList_ =
            classList
                [ ( "block", True )
                , ( "active", (block.id == active) )
                ]
    in
        div [ attribute "data-id" block.id, classList_ ]
            [ div [ class "header" ]
                [ p [] [ text "Bibliografia" ]
                , div
                    [ class "close-button"
                    , onClickID deleteBlock
                    ]
                    [ i [ class "fa fa-times fa-fw" ] [] ]
                ]
            ]


parseChildren : BlockChildren -> BlockID -> List (Html Message)
parseChildren children active =
    let
        view_ =
            (\child -> view child active)
    in
        case children of
            Some children ->
                List.map view_ children

            None ->
                []


deleteBlock : BlockID -> Message
deleteBlock id =
    (Document (Structure (DeleteBlock id)))


onClickID : (BlockID -> msg) -> Html.Attribute msg
onClickID message =
    Events.on "click" (Json.map message targetID)


targetID : Json.Decoder String
targetID =
    Json.at [ "target", "data-id" ] Json.string
