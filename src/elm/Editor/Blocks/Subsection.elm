module Editor.Blocks.Subsection exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


html : String -> List (Html msg) -> Html msg
html heading children =
    div [ class "subsection" ]
        [ div [ class "header" ] [ text ("Seção: " ++ heading) ]
        , div [] children
        ]
