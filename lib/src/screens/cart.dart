import 'package:cartvorie/config/route_guard.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/CartModel.dart';
import 'package:cartvorie/src/models/product.dart';
import 'package:cartvorie/src/provider/cart_provider.dart';
import 'package:cartvorie/src/widgets/CartItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class CartWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final cartList = useProvider(cartProvider);
    final cartTotal = useProvider(cartSubTotalProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon:
              new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          // leading: Icon(
          //   UiIcons.shopping_cart,
          //   color: Theme.of(context).hintColor,
          // ),
          title: Text(
            'Shopping Cart',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.display1,
          ),
          subtitle: Text(
            'Verify your quantity before checkout',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        actions: <Widget>[
          GuardedWidget(
            guardedWidget: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  onTap: () {
                    Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('img/logo.png'),
                  ),
                )),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          cartTotal > 0
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: StickyGroupedListView<CartItem, String>(
                    elements: cartList,
                    groupBy: (CartItem element) => element.storeId.toString(),
                    groupSeparatorBuilder: (CartItem element) => Container(
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFCC00FF),
                            border: Border.all(
                              color: Color(0xFFCC00FF),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Store: ${element.storeName}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // itemComparator: (element1, element2) => element1.storeName
                    //     .compareTo(element2.storeName), // optional
                    order: StickyGroupedListOrder.ASC, // optional
                    itemBuilder: (context, CartItem element) {
                      return Dismissible(
                          onDismissed: (_) {
                            context.read(cartListProvider).remove(element);
                          },
                          key: UniqueKey(),
                          child: CartItemWidget(
                              cartItem: element, heroTag: 'cart'));
                    },
                  ),
                )
              // ListView.separated(
              //     padding: EdgeInsets.symmetric(vertical: 5),
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     primary: false,
              //     itemCount: cartList.length,
              //     separatorBuilder: (context, index) {
              //       return SizedBox(height: 8);
              //     },
              //     itemBuilder: (context, index) {
              //       return Dismissible(
              //           onDismissed: (_) {
              //             context
              //                 .read(cartListProvider)
              //                 .remove(cartList[index]);
              //           },
              //           key: UniqueKey(),
              //           child: CartItemWidget(
              //               cartItem: cartList.elementAt(index),
              //               heroTag: 'cart'));
              //     },
              //   )
              : Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cart is empty",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        _gestureClicker("Start Shopping", "/Brands")
                      ],
                    ),
                  ),
                ),
          cartTotal > 0
              ? Positioned(
                  bottom: 0,
                  child: Container(
                    // height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.15),
                              offset: Offset(0, -2),
                              blurRadius: 5.0)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Subtotal',
                                  style: Theme.of(context).textTheme.body2,
                                ),
                              ),
                              Text('\$' + cartTotal.toStringAsFixed(3),
                                  style: Theme.of(context).textTheme.subhead),
                            ],
                          ),
                          SizedBox(height: 15),
                          Stack(
                            fit: StackFit.loose,
                            alignment: AlignmentDirectional.centerEnd,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/Checkout');
                                  },
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  color: Theme.of(context).accentColor,
                                  shape: StadiumBorder(),
                                  child: Text(
                                    'Checkout',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 20),
                              //   child: Text(
                              //     '\$$cartTotal',
                              //     style: Theme.of(context).textTheme.display1.merge(
                              //         TextStyle(
                              //             color: Theme.of(context).primaryColor)),
                              //   ),
                              // )
                            ],
                          ),
                          // SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
      // body: StickyGroupedListView<CartItem, String>(
      //   elements: cartList,
      //   groupBy: (CartItem element) => element.storeName,
      //   groupSeparatorBuilder: (CartItem element) => Text(element.storeName),
      //   // itemBuilder: (context, CartItem element) =>
      //   //     Text(element.storeName),
      //   itemComparator: (element1, element2) =>
      //       element1.storeName.compareTo(element2.storeName), // optional
      //   order: StickyGroupedListOrder.ASC, // optional
      //   itemBuilder: (context, CartItem element) {
      //     return Card(
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(6.0),
      //       ),
      //       elevation: 8.0,
      //       margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      //       child: Container(
      //         child: ListTile(
      //           contentPadding:
      //               EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      //           leading: Icon(Icons.check),
      //           title: Text(element.name),
      //           trailing: Text('${element.price}'),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class _gestureClicker extends StatelessWidget {
  const _gestureClicker(this.btnTxt, this.linker);
  final String btnTxt;
  final String linker;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        linker == "/PickupDelivery"
            ? Navigator.of(context).pushNamed("/Tabs", arguments: 3)
            : Navigator.of(context).pushNamed(linker);
      },
      child: Container(
        width: size.width / 2.5,
        margin: EdgeInsets.only(right: 20),
        height: 40,
        decoration: BoxDecoration(
          // color: Colors.purple,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          gradient: LinearGradient(
            colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
          ),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 9)
          ],
        ),
        child: Center(
          // padding: EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                btnTxt,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
