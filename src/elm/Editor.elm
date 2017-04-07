module Editor exposing (..)

import Html exposing (Html, div, text)
import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(..), RouteUrlProgram, UrlChange)


type alias Model =
    String


type Message
    = Nothing
    | Something


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    Just (UrlChange ModifyEntry "/")


location2messages : Location -> List Message
location2messages location =
    []


init : ( Model, Cmd Message )
init =
    ( "", Cmd.none )


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        Nothing ->
            ( "", Cmd.none )

        Something ->
            ( "S", Cmd.none )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


view : Model -> Html Message
view model =
    div [] [ text "Null" ]


main : RouteUrlProgram Never Model Message
main =
    RouteUrl.program
        { delta2url = delta2url
        , location2messages = location2messages
        , init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
