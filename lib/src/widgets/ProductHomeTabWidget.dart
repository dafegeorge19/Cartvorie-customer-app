import 'package:cartvorie/src/models/product_color.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/product_size.dart';
import 'package:flutter/material.dart';

class ProductHomeTabWidget extends StatefulWidget {
  final ProductData product;

  ProductHomeTabWidget({this.product});

  @override
  ProductHomeTabWidgetState createState() => ProductHomeTabWidgetState();
}

class ProductHomeTabWidgetState extends State<ProductHomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.product.name.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.display2.merge(TextStyle(
                        fontSize: 16,
                      )),
                ),
              ),
              Chip(
                padding: EdgeInsets.all(0),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.product.stock.toString(),
                        style: Theme.of(context).textTheme.body2.merge(
                            TextStyle(color: Theme.of(context).primaryColor))),
                    Icon(
                      Icons.store,
                      color: Theme.of(context).primaryColor,
                      size: 16,
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                shape: StadiumBorder(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(widget.product.salesPrice,
                  style: Theme.of(context).textTheme.display3),
              SizedBox(width: 10),
              Text(
                widget.product.price,
                style: Theme.of(context).textTheme.headline.merge(TextStyle(
                    color: Theme.of(context).focusColor,
                    decoration: TextDecoration.lineThrough)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${widget.product.stock} In Stock',
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
