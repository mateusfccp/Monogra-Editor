module Editor.Blocks.Section.View exposing (..)

import Editor.Blocks.Section.Model exposing (..)
import Html exposing (Html, div, i, p, text)
import Html.Attributes exposing (class)


html : SectionType -> List (Html msg) -> Html msg
html sectiontype children =
    case sectiontype of
        Cover ->
            div [ class "block section cover" ]
                [ div [ class "header" ] [ text "Capa" ]
                , div [ class "close-button" ] [ i [ class "fa fa-times fa-fw" ] [] ]
                , p [] [ text "Este bloco representa a capa." ]
                ]

        Index ->
            div [ class "block section index" ]
                [ div [ class "header" ] [ text "Índice" ]
                , div [ class "close-button" ] [ i [ class "fa fa-times fa-fw" ] [] ]
                , p [] [ text "Aqui será renderizada uma representação do índice." ]
                ]

        Body ->
            div [ class "block section body" ]
                ([ div [ class "header" ] [ text "Corpo" ]
                 , div [ class "close-button" ] [ i [ class "fa fa-times fa-fw" ] [] ]
                 ]
                    ++ children
                )

        Bibliography ->
            div [ class "block section bibliography" ]
                [ div [ class "header" ] [ text "Bibliografia" ]
                , div [ class "close-button" ] [ i [ class "fa fa-times fa-fw" ] [] ]
                , p [] [ text "Aqui será renderizada uma representação da bibliografia." ]
                ]
