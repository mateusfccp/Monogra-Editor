module Editor.Blocks.Subsection.View exposing (..)

import Html exposing (Html, div, i, text)
import Html.Attributes exposing (class)


html : String -> List (Html msg) -> Html msg
html header children =
    div [ class "block subsection" ]
        [ div [ class "header" ] [ text ("Seção: " ++ header) ]
        , div [ class "close-button" ] [ i [ class "fa fa-times fa-fw" ] [] ]
        , div [] children
        ]
