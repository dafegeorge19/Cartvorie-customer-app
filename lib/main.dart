import 'package:hooks_riverpod/all.dart';

import 'config/app_config.dart' as config;
import 'package:flutter/material.dart';

import 'route_generator.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartvorie',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        backgroundColor: Color(0xff652f91),
        accentColor: config.AppColors().mainDarkColor(1),
        hintColor: config.AppColors().secondDarkColor(1),
        focusColor: config.AppColors().accentDarkColor(1),

        textTheme: TextTheme(
          button: TextStyle(color: Color(0xFF252525)),
          headline5: TextStyle(fontSize: 20.0, color: config.AppColors().secondDarkColor(1)),
          headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.AppColors().secondDarkColor(1)),
          headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.AppColors().secondDarkColor(1)),
          headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.AppColors().mainDarkColor(1)),
          headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.AppColors().secondDarkColor(1)),
          subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.AppColors().secondDarkColor(1)),
          headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.AppColors().mainDarkColor(1)),
          bodyText2: TextStyle(fontSize: 12.0, color: config.AppColors().secondDarkColor(1)),
          bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.AppColors().secondDarkColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.AppColors().secondDarkColor(0.7)),
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        backgroundColor: Color(0xff652f91),
        accentColor: config.AppColors().mainColor(1),
        focusColor: config.AppColors().accentColor(1),

        hintColor: config.AppColors().secondColor(1),
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
          headline5: TextStyle(fontSize: 20.0, color: config.AppColors().secondColor(1)),
          headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.AppColors().secondColor(1)),
          headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.AppColors().secondColor(1)),
          headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.AppColors().mainColor(1)),
          headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.AppColors().secondColor(1)),
          subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.AppColors().secondColor(1)),
          headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.AppColors().mainColor(1)),
          bodyText2: TextStyle(fontSize: 12.0, color: config.AppColors().secondColor(1)),
          bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.AppColors().secondColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.AppColors().secondColor(0.6)),
        ),
      ),
    );
  }
}
