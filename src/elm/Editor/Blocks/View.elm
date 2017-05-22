module Editor.Blocks.Block exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Editor.Messages exposing (..)
import Editor.Blocks.Model exposing (..)
import Editor.Blocks.Paragraph.View as Paragraph
import Editor.Blocks.Section.View as Section
import Editor.Blocks.Subsection.View as Subsection


view : BlockNode -> BlockID -> Html Message
view block active =
    let
        html =
            case block.value of
                Paragraph paragraphType content ->
                    Paragraph.html content (block.id == active)

                Root ->
                    div [ class "document" ] (parseChildren block.children active)

                Section sectionType ->
                    Section.html sectionType (parseChildren block.children active)

                Subsection header ->
                    Subsection.html header (parseChildren block.children active)
    in
        html


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
