import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'app_loader.dart';

Widget appNetworkImage(String url) {
  return CachedNetworkImage(
    imageUrl: '$url',
    placeholder: (context, url) => imageLoader,
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

final imageLoader = LiquidLinearProgressIndicator(
  value: 0.25, // Defaults to 0.5.
  valueColor: AlwaysStoppedAnimation(
      Colors.purple), // Defaults to the current Theme's accentColor.
  backgroundColor:
      Colors.white, // Defaults to the current Theme's backgroundColor.
  direction: Axis
      .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
  center: Text("Loading..."),
);
