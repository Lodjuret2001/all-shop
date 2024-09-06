module Functions.Api exposing (..)

import Http exposing (..)
import Json.Decode exposing (..)
import Types exposing (..)


productsDecoder : Decoder (List Product)
productsDecoder =
    field "products" (list productDecoder)


productDecoder : Decoder Product
productDecoder =
    Json.Decode.map6 Product
        (field "id" int)
        (field "title" string)
        (field "price" float)
        (field "description" string)
        (field "category" string)
        (field "images" (list string))


getProducts : Cmd Msg
getProducts =
    Http.get
        { url = "https://dummyjson.com/products"
        , expect = Http.expectJson HandleFetchProducts productsDecoder
        }


validateError : Http.Error -> String
validateError error =
    case error of
        Http.BadUrl _ ->
            "The URL was invalid..."

        Http.Timeout ->
            "The request timed out. Please try again later."

        Http.NetworkError ->
            "There was a network error. Please check your internet connection."

        Http.BadStatus _ ->
            "Received a bad status code"

        Http.BadBody _ ->
            "Failed to decode the data"
