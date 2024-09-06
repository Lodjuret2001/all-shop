module Main exposing (..)

import Browser exposing (..)
import Components.NavMenu exposing (..)
import Functions.Api exposing (..)
import Functions.Cart exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Pages.Cart exposing (..)
import Pages.Checkout exposing (..)
import Pages.Home exposing (..)
import Process
import Task
import Types exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = viewMain
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { products = [], cart = [], currentPage = Home, isLoading = True, error = Nothing }, getProducts )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchProducts ->
            ( { model | isLoading = True }, getProducts )

        HandleFetchProducts result ->
            case result of
                Ok products ->
                    ( { model | products = products, isLoading = False }, Cmd.none )

                Err error ->
                    ( { model | error = Just (validateError error), isLoading = False }, Cmd.none )

        NavToHome ->
            ( { model | currentPage = Home }, Cmd.none )

        NavToCart ->
            ( { model | currentPage = Cart }, Cmd.none )

        NavToCheckout ->
            ( { model | currentPage = Checkout }, Cmd.none )

        AddToCartList product ->
            ( { model | cart = updateCart product model.cart }, Cmd.none )

        RemoveFromCartList product ->
            ( { model | cart = decrementCartQuantity product model.cart }, Cmd.none )

        BuyNow product ->
            ( { model | cart = { product = product, quantity = 1 } :: model.cart, currentPage = Checkout }, Cmd.none )

        ProcessPayment ->
            ( { model | isLoading = True }
            , Task.perform (\_ -> PaymentProcessed) (Process.sleep 5000)
            )

        PaymentProcessed ->
            ( { model | isLoading = False, cart = [], currentPage = Home }, Cmd.none )


viewMain : Model -> Html Msg
viewMain model =
    div [ class "main-container" ]
        [ viewNavMenu model navLinks
        , p [ class "info" ]
            [ if model.isLoading then
                text "Loading..."

              else
                text ""
            ]
        , p [ class "info" ]
            [ if List.length model.products == 0 then
                text "Could not find any products to display..."

              else
                text ""
            ]
        , p []
            [ case model.error of
                Just errMsg ->
                    text errMsg

                Nothing ->
                    text ""
            ]
        , case model.currentPage of
            Home ->
                Pages.Home.viewHome model

            Cart ->
                Pages.Cart.viewCart model

            Checkout ->
                Pages.Checkout.viewCheckout model
        ]
