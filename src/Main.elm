module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Http
import Json.Decode exposing (Decoder, field, string)


---- MODEL ----


type alias Model =
    {
      flag: String
    }


init : String -> ( Model, Cmd Msg )
init flag =
    ( {flag = flag}, Http.get { url = "api/hello", expect = Http.expectJson GotJson jsonDecoder } )


jsonDecoder : Decoder String
jsonDecoder =
  field "name" string

---- UPDATE ----


type Msg
    = NoOp
    | GotJson (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )

    GotJson result ->
      case result of
        Ok string ->
          ( { flag = string }, Cmd.none )

        Err _ ->
          ( { flag = "Error" }, Cmd.none )


---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/vercel.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , h1 [] [ text model.flag ]
        ]



---- PROGRAM ----


main : Program String Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }

