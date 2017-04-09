module Editor exposing (..)

import Editor.Blocks.Block as Block exposing (Block)
import Editor.Blocks.Section as Section
import Editor.Document as Document exposing (Document, DocumentMeta)
import Html exposing (Html, div, hr, p, text)
import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(..), RouteUrlProgram, UrlChange)


type alias Model =
    Document


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
    ( Document
        (DocumentMeta
            [ "Twinsen The Mateus", "Kress The Christian" ]
            [ "algo", "outralgo", "maisalgo" ]
            "O algo do algo no contexto de algo"
            "Abstract"
        )
        [ Block.Section Section.Cover []
        , Block.Section Section.Index []
        , Block.Section Section.Body
            [ Block.Subsection "Parte 1"
                [ Block.Paragraph "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in leo nulla. Donec hendrerit mi non ullamcorper ultricies. Mauris suscipit quam a urna pulvinar, eu cursus nisi congue. Sed bibendum odio id turpis consectetur, ac facilisis nibh bibendum. Aliquam erat volutpat. Donec fermentum elit odio, ut vulputate tortor dictum id. Aliquam blandit ultrices congue. Fusce sit amet nibh ut nibh pretium accumsan nec sed nulla. Praesent commodo nulla augue, at ornare eros consequat sed. Aenean in aliquam sapien, et pellentesque purus. Proin ipsum neque, sodales eget odio nec, interdum tincidunt ex. Quisque vel velit a leo gravida posuere. In non dui quis massa mattis convallis. Nunc condimentum lacus dui, vel pretium turpis condimentum at. Sed in felis purus."
                , Block.Paragraph "Suspendisse cursus tempor ante hendrerit faucibus. Vestibulum non pretium mauris, eu viverra est. In consectetur molestie ligula, in facilisis tortor tincidunt eget. Cras aliquet consequat turpis. Suspendisse ultricies cursus rhoncus. Pellentesque nec leo rhoncus, euismod nisl quis, luctus nunc. Etiam malesuada dapibus laoreet. Maecenas bibendum dictum purus eu bibendum. Sed at velit in dui varius aliquet. Morbi laoreet pharetra eros, sed rhoncus sapien. Sed finibus diam leo, id porttitor mi posuere ut. Suspendisse ipsum quam, pellentesque et sapien vitae, gravida iaculis urna."
                ]
            , Block.Subsection "Parte 2"
                [ Block.Subsection "Subparte 1"
                    [ Block.Paragraph "Phasellus vestibulum, odio id mattis scelerisque, tellus tellus suscipit nunc, sit amet malesuada est nisl non diam. Ut quis magna eros. Nullam elementum lectus vel arcu aliquam, at vulputate orci molestie. Sed pellentesque nunc massa. Nam aliquet lorem hendrerit molestie tincidunt. Etiam efficitur risus quis aliquam interdum. Pellentesque vehicula massa ullamcorper lorem egestas euismod. Proin commodo fermentum ligula nec auctor. Vestibulum efficitur in lectus id gravida. Quisque vestibulum, risus a euismod interdum, urna eros semper ex, quis semper lectus neque eu magna."
                    ]
                ]
            , Block.Subsection "Subparte 2"
                [ Block.Paragraph "Nunc nec lacinia ligula. Cras ac ipsum at justo placerat molestie sit amet id nisl. Praesent dictum massa a lectus blandit bibendum. Sed condimentum, mauris nec dictum finibus, lacus libero congue metus, et dignissim ante tellus vitae ex. Maecenas massa nibh, cursus ut tincidunt ut, ornare ac metus. Quisque risus erat, tincidunt et dictum iaculis, porta a eros. Praesent condimentum arcu ac purus accumsan, quis lobortis elit eleifend. Nunc bibendum, quam in posuere tincidunt, lectus ante fringilla velit, a consequat dui ex quis ligula. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam convallis imperdiet urna ac pulvinar. Etiam turpis neque, congue id eros nec, facilisis blandit ipsum. Phasellus at mattis elit. Sed et vulputate leo. Aliquam ornare mattis massa in dapibus."
                , Block.Paragraph "Pellentesque id odio eu lectus tincidunt placerat ut nec felis. Praesent at risus interdum, eleifend massa quis, aliquam elit. Morbi scelerisque eget erat a semper. Etiam consectetur tempus dictum. Phasellus quis orci laoreet, sollicitudin nibh a, finibus augue. Duis venenatis eget dui non porta. Morbi sit amet ipsum ac diam efficitur rutrum a ac risus. Sed vel imperdiet metus, eu sodales felis. Vestibulum viverra tortor vel dolor vehicula eleifend. Praesent eget purus eu ante congue sollicitudin nec sed lorem. Sed tortor odio, lobortis fermentum nibh sed, imperdiet convallis ante. Vestibulum aliquam, massa quis molestie euismod, nisl sapien facilisis lacus, vel malesuada dui est nec libero. Sed rhoncus, nisl non laoreet ultricies, eros metus luctus libero, vitae commodo dolor quam a ligula. Praesent elit augue, ullamcorper a scelerisque a, sodales vel libero."
                ]
            ]
        , Block.Section Section.Bibliography []
        ]
    , Cmd.none
    )


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        Nothing ->
            init

        Something ->
            init


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


view : Model -> Html Message
view model =
    div []
        [ p [] [ text ("Editando " ++ model.meta.title) ]
        , p [] [ text ("Autor(es): " ++ concatAuthors ", " model.meta.authors) ]
        , hr [] []
        , Document.html model.structure
        ]


concatAuthors : String -> List String -> String
concatAuthors c list =
    list |> List.intersperse c |> List.foldr (++) ""


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
