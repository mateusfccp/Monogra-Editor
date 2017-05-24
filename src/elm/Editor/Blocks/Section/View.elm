module Editor.Blocks.Section.View exposing (..)

import Editor.Blocks.Section.Model exposing (..)
import Html exposing (Html, div, i, p, text)


class : SectionType -> List ( String, Bool )
class sectionType =
    let
        ( cover, index, body, bibliography ) =
            case sectionType of
                Cover ->
                    ( True, False, False, False )

                Index ->
                    ( False, True, False, False )

                Body ->
                    ( False, False, True, False )

                Bibliography ->
                    ( False, False, False, True )
    in
        [ ( "section", True )
        , ( "cover", cover )
        , ( "index", index )
        , ( "body", body )
        , ( "bibliography", bibliography )
        ]


events : List (Html.Attribute msg)
events =
    []


header : SectionType -> String
header sectionType =
    case sectionType of
        Cover ->
            "Capa"

        Index ->
            "Índice"

        Body ->
            "Corpo"

        Bibliography ->
            "Bibliografia"


html : SectionType -> List (Html msg) -> List (Html msg)
html sectionType children =
    case sectionType of
        Cover ->
            [ p [] [ text "Este bloco representa a capa." ] ]

        Index ->
            [ p [] [ text "Aqui será renderizada uma representação do índice." ] ]

        Body ->
            children

        Bibliography ->
            [ p [] [ text "Aqui será renderizada uma representação da bibliografia." ] ]
