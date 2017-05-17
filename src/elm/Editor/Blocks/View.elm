module Editor.Blocks.Block exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Editor.Blocks.Model exposing (..)
import Editor.Blocks.Paragraph.View as Paragraph
import Editor.Blocks.Section.View as Section
import Editor.Blocks.Subsection.View as Subsection


view : BlockNode -> Html msg
view block =
    let
        inner =
            case block.value of
                Paragraph paragraphType content ->
                    Paragraph.html content

                Root ->
                    div [] (parseChildren block.children)

                Section sectionType ->
                    Section.html sectionType (parseChildren block.children)

                Subsection heading ->
                    Subsection.html heading (parseChildren block.children)
    in
        div [ class "block" ] [ inner ]


parseChildren : BlockChildren -> List (Html msg)
parseChildren children =
    case children of
        Some children ->
            List.map view children

        None ->
            []
