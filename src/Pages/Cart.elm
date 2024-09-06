module Pages.Cart exposing (..)

import Debug exposing (..)
import Functions.Cart exposing (calculateSubTotal, roundToTwoDecimals)
import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Pages.Home exposing (findProductImage)
import Types exposing (..)


viewCart : Model -> Html Msg
viewCart model =
    div [ class "container" ]
        [ h1 [] [ text "Cart" ]
        , if List.length model.cart == 0 then
            viewEmptyCart

          else
            div []
                [ div [] (List.map viewCartProduct model.cart)
                , p [ class "cart-subtotal" ] [ text (calculateSubTotal model.cart) ]
                , button [ class "nav-button", onClick NavToCheckout ] [ text "Checkout" ]
                ]
        ]


viewEmptyCart : Html Msg
viewEmptyCart =
    div []
        [ p [] [ text "Your cart is empty! Add some products to proceed!" ]
        , button [ class "nav-button", onClick NavToHome ] [ text "See products!" ]
        ]


viewCartProduct : CartProduct -> Html Msg
viewCartProduct cartProduct =
    div [ class "cart-card" ]
        [ img [ class "cart-image", src (findProductImage cartProduct.product.images) ] []
        , p [ class "cart-title" ] [ text (cartProduct.product.title ++ " - " ++ cartProduct.product.category) ]
        , p [ class "cart-price" ] [ text (String.fromFloat (roundToTwoDecimals (cartProduct.product.price * toFloat cartProduct.quantity)) ++ " USD") ]
        , p [ class "cart-quantity" ] [ text ("Quantity: " ++ String.fromInt cartProduct.quantity ++ " st") ]
        , div [ class "cart-buttons" ]
            [ button [ class "increment--cart", onClick (AddToCartList cartProduct.product) ] [ text "+" ]
            , button [ class "decrement--cart", onClick (RemoveFromCartList cartProduct.product) ] [ text "-" ]
            ]
        ]
