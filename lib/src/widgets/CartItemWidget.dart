import 'package:cartvorie/src/models/CartModel.dart';
import 'package:cartvorie/src/models/product.dart';
import 'package:cartvorie/src/models/route_argument.dart';
import 'package:cartvorie/src/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItemWidget extends HookWidget {
  final String heroTag;
  final CartItem cartItem;

  CartItemWidget({this.heroTag, this.cartItem});

  @override
  Widget build(BuildContext context) {
    final quantity = useState(1);
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed(
          '/Product',
          arguments: RouteArgument(
              id: cartItem.productId, argumentsList: [cartItem, heroTag]),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag +
                  cartItem.productId.toString() +
                  cartItem.quantity.toString(),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      image: NetworkImage(cartItem.image), fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          cartItem.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        Text(
                          cartItem.price,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text(
                          cartItem.storeName.toString(),
                          style: Theme.of(context).textTheme.display1.merge(
                              TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),

                  ///improve cart
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          quantity.value = cartItem.quantity + 1;
                          context.read(cartListProvider).edit(CartItem(
                              productId: cartItem.productId,
                              price: cartItem.price,
                              name: cartItem.name,
                              image: cartItem.image,
                              quantity: quantity.value,
                              storeId: cartItem.storeId,
                              storeName: cartItem.storeName));
                        },
                        iconSize: 20,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.add_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                      Text(cartItem.quantity.toString(),
                          style: Theme.of(context).textTheme.subhead),
                      IconButton(
                        onPressed: () {
                          quantity.value = cartItem.quantity - 1;
                          context.read(cartListProvider).edit(CartItem(
                              productId: cartItem.productId,
                              price: cartItem.price,
                              name: cartItem.name,
                              image: cartItem.image,
                              quantity: quantity.value,
                              storeId: cartItem.storeId,
                              storeName: cartItem.storeName));
                        },
                        iconSize: 20,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.remove_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  incrementQuantity(int quantity) {
    if (quantity <= 99) {
      return ++quantity;
    } else {
      return quantity;
    }
  }

  decrementQuantity(int quantity) {
    if (quantity > 1) {
      return --quantity;
    } else {
      return quantity;
    }
  }
}
