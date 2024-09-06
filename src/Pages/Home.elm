module Pages.Home exposing (..)

import Debug exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Types exposing (..)


viewHome : Model -> Html Msg
viewHome model =
    div [ class "container" ]
        [ h1
            []
            [ text "Welcome To the All Shop!" ]
        , div [ class "product-grid" ] (List.map viewProduct model.products)
        , button [ class "nav-button", onClick NavToCart ] [ text "Navigate to cart" ]
        ]


viewProduct : Product -> Html Msg
viewProduct product =
    div [ class "product-card" ]
        [ img [ class "product-image", src (findProductImage product.images) ] []
        , p [ class "product-title" ] [ text (product.title ++ " - " ++ product.category) ]
        , p [ class "product-price" ] [ text (String.fromFloat product.price ++ " USD") ]
        , button [ class "add-to--cart", onClick (AddToCartList product) ] [ text "Add to Cart" ]
        , button [ class "add-to--checkout", onClick (BuyNow product) ] [ text "Buy Now!" ]
        ]


findProductImage : List String -> String
findProductImage images =
    case List.head images of
        Just image ->
            image

        Nothing ->
            "Could not find product image :("
