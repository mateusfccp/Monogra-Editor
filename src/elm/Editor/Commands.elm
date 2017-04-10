module Editor.Commands exposing (..)

import Editor.Document exposing (decoder)

fetchDocument Cmd msg
fetchdocument = Http.get "localhost:4000/db" Document.decoder
