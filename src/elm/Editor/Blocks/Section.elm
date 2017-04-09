module Editor.Blocks.Section exposing (..)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (property)
import Json.Encode as Encode


type SectionType
    = Cover
    | Index
    | Body
    | Bibliography


html : SectionType -> List (Html msg) -> Html msg
html sectiontype children =
    case sectiontype of
        Cover ->
            div []
                [ p [ property "className" (Encode.string "p2 border rounded") ] [ text "Capa" ]
                ]

        Index ->
            div []
                [ p [ property "className" (Encode.string "p2 border rounded") ] [ text "Índice" ]
                ]

        Body ->
            div [ property "className" (Encode.string "p2 border rounded") ]
                children

        Bibliography ->
            div []
                [ p [ property "className" (Encode.string "p2 border rounded") ] [ text "Bibliografia" ]
                ]
