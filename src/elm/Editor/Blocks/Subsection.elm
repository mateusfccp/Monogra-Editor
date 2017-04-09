module Editor.Blocks.Subsection exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (property)
import Json.Encode as Encode


html : String -> List (Html msg) -> Html msg
html heading children =
    div [ property "className" (Encode.string "overflow-hidden border rounded") ]
        [ div [ property "className" (Encode.string "p2 bold white bg-blue") ] [ text ("Subseção: " ++ heading) ]
        , div [ property "className" (Encode.string "p2") ] children
        ]
