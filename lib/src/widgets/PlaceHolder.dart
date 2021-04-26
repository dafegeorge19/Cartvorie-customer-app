import 'package:flutter/material.dart';

class PlaceHolderWidget extends StatelessWidget {
  final placeHolderText;

  const PlaceHolderWidget({Key key, @required this.placeHolderText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(placeHolderText),);
  }
}
