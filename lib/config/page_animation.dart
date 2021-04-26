// import 'package:flutter/material.dart';

// PageController _pageController;

// AnimationController rippleController;
// AnimationController scaleController;

// Animation<double> rippleAnimation;
// Animation<double> scaleAnimation;

// @override
// void initState() {
//   super.initState();

//   _pageController = PageController(initialPage: 0);

//   rippleController =
//       AnimationController(vsync: this, duration: Duration(seconds: 1));

//   // scaleController = AnimationController(
//   //   vsync: this,
//   //   duration: Duration(seconds: 1)
//   // )..addStatusListener((status) {
//   //   if (status == AnimationStatus.completed) {
//   //     Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Dashboard()));
//   //   }
//   // });

//   rippleAnimation =
//       Tween<double>(begin: 80.0, end: 90.0).animate(rippleController)
//         ..addStatusListener((status) {
//           if (status == AnimationStatus.completed) {
//             rippleController.reverse();
//           } else if (status == AnimationStatus.dismissed) {
//             rippleController.forward();
//           }
//         });

//   scaleAnimation =
//       Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);

//   rippleController.forward();
// }
