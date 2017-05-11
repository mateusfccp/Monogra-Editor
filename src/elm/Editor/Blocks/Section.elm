module Editor.Blocks.Section exposing (..)

import Editor.Models exposing (SectionType(..))
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)


html : SectionType -> List (Html msg) -> Html msg
html sectiontype children =
    case sectiontype of
        Cover ->
            div [ class "section cover" ]
                [ div [ class "header" ] [ text "Capa" ]
                , p [] [ text "Este bloco representa a capa." ]
                ]

        Index ->
            div [ class "section index" ]
                [ div [ class "header" ] [ text "Índice" ]
                , p [] [ text "Aqui será renderizada uma representação do índice." ]
                ]

        Body ->
            div [ class "section body" ]
                ([ div [ class "header" ] [ text "Corpo" ] ] ++ children)

        Bibliography ->
            div [ class "section bibliography" ]
                [ div [ class "header" ] [ text "Bibliografia" ]
                , p [] [ text "Aqui será renderizada uma representação da bibliografia." ]
                ]
