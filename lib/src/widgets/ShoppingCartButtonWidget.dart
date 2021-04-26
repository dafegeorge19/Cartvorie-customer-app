import 'dart:ui';

import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShoppingCartButtonWidget extends HookWidget {
  const ShoppingCartButtonWidget({
    this.iconColor,
    this.labelColor,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    final labelCount = useProvider(cartCountProvider);
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/Cart');
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              UiIcons.shopping_cart,
              color: this.iconColor,
              size: 28,
            ),
          ),
          Container(

            child: Text(
          '${labelCount.toString()}',

              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.merge(
                    TextStyle(color: Theme.of(context).primaryColor, fontSize: 9),
                  ),
            ),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(color: this.labelColor, borderRadius: BorderRadius.all(Radius.circular(10))),
            constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
          ),
        ],
      ),
      color: Colors.transparent,
    );
  }
}
