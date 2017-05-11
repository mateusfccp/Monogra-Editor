module Editor.Blocks.Subsection exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


html : String -> List (Html msg) -> Html msg
html heading children =
    div [ class "overflow-hidden" ]
        [ div [] [ text ("Subseção: " ++ heading) ]
        , div [] children
        ]
