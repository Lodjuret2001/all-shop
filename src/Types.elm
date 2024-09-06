module Types exposing (..)

import Http exposing (..)


type alias Model =
    { products : List Product
    , cart : List CartProduct
    , currentPage : Pages
    , isLoading : Bool
    , error : Maybe String
    }


type Pages
    = Home
    | Cart
    | Checkout


type Msg
    = FetchProducts
    | HandleFetchProducts (Result Http.Error (List Product))
    | NavToHome
    | NavToCart
    | NavToCheckout
    | AddToCartList Product
    | BuyNow Product
    | RemoveFromCartList Product
    | ProcessPayment
    | PaymentProcessed


type alias Product =
    { id : Int
    , title : String
    , price : Float
    , description : String
    , category : String
    , images : List String
    }


type alias CartProduct =
    { product : Product
    , quantity : Int
    }
