module Pages.Checkout exposing (..)

import Functions.Cart exposing (calculateSubTotal)
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Pages.Cart exposing (viewEmptyCart)
import Types exposing (..)


viewCheckout : Model -> Html Msg
viewCheckout model =
    div [ class "container" ]
        [ h1 [] [ text "Cart" ]
        , if List.length model.cart == 0 then
            viewEmptyCart

          else
            div []
                [ p [ class "checkout-total" ] [ text ("Total: " ++ calculateSubTotal model.cart) ]
                , button [ onClick ProcessPayment ] [ text "Pay" ]
                ]
        ]
