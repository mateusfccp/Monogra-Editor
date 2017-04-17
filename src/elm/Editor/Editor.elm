module Editor exposing (..)

import Editor.Commands exposing (fetchDocument)
import Editor.Models as Models exposing (..)
import Editor.Messages exposing (Message(..))
import Editor.Subscriptions exposing (subscriptions)
import Editor.Update exposing (update)
import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(..), RouteUrlProgram, UrlChange)
import Editor.View exposing (view)


init : ( Model, Cmd Message )
init =
    ( initialModel, fetchDocument )


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    Just (UrlChange ModifyEntry "/")


location2messages : Location -> List Message
location2messages location =
    []


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
