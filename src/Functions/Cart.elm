module Functions.Cart exposing (..)

import Types exposing (..)


updateCart : Product -> List CartProduct -> List CartProduct
updateCart product cart =
    if List.any (\cartProduct -> cartProduct.product.id == product.id) cart then
        -- If product exists, increment the quantity
        List.map
            (\cartProduct ->
                if cartProduct.product.id == product.id then
                    { cartProduct | quantity = cartProduct.quantity + 1 }

                else
                    cartProduct
            )
            cart

    else
        -- If product doesn't exist, add it to the cart with quantity 1
        { product = product, quantity = 1 } :: cart


decrementCartQuantity : Product -> List CartProduct -> List CartProduct
decrementCartQuantity product cart =
    List.filterMap
        (\cartProduct ->
            if cartProduct.product.id == product.id then
                if cartProduct.quantity > 1 then
                    Just { cartProduct | quantity = cartProduct.quantity - 1 }

                else
                    Nothing
                -- Remove the product if the quantity is 1

            else
                Just cartProduct
         -- Keep other products as-is
        )
        cart


calculateSubTotal : List CartProduct -> String
calculateSubTotal cart =
    let
        total =
            List.foldl
                (\cartProduct acc ->
                    acc + (cartProduct.product.price * toFloat cartProduct.quantity)
                )
                0
                cart

        roundedTotal =
            roundToTwoDecimals total
    in
    String.fromFloat roundedTotal ++ " USD"


roundToTwoDecimals : Float -> Float
roundToTwoDecimals number =
    toFloat (Basics.round (number * 100)) / 100
