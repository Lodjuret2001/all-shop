module Components.NavMenu exposing (..)

import Debug exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Types exposing (..)


type alias Navlink =
    { text : String
    , active : Pages
    , view : Msg
    }


navLinks : List Navlink
navLinks =
    [ { text = "Home", active = Home, view = NavToHome }
    , { text = "Cart", active = Cart, view = NavToCart }
    , { text = "Checkout", active = Checkout, view = NavToCheckout }
    ]


viewNavLinks : Navlink -> Model -> Html Msg
viewNavLinks link model =
    a
        [ if model.currentPage == link.active then
            class "nav-link nav-link--active"

          else
            class "nav-link"
        , onClick link.view
        ]
        [ text link.text ]


viewLogo : String -> Html Msg
viewLogo link =
    div []
        [ img [ src link, class "logo" ] []
        ]


viewNavMenu : Model -> List Navlink -> Html Msg
viewNavMenu model links =
    nav []
        [ viewLogo "assets/logo.png"
        , div [ class "nav-link--container" ]
            (List.map (\link -> viewNavLinks link model) links)
        ]
