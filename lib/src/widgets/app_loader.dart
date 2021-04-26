import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

final appLoader = Center(
  child: Container(
    width: 80,
    height: 80,
    child: SleekCircularSlider(
        appearance: CircularSliderAppearance(
      spinnerMode: true,
    )),
  ),
);
