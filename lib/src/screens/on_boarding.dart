import 'package:carousel_slider/carousel_slider.dart';
import 'package:cartvorie/config/app_config.dart' as config;
import 'package:cartvorie/src/models/on_boarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cartvorie/config/user_preference.dart';

class OnBoardingWidget extends StatefulWidget {
  @override
  _OnBoardingWidgetState createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  int _current = 0;
  // OnBoardingList _onBoardingList;
  PageController controller;
  @override
  void initState() {
    getPref();
    // _onBoardingList = new OnBoardingList();
    super.initState();
    controller = new PageController();
  }

  Future getPref() async {
    String isOpened = await AppOpened().getOpenState();
    if (isOpened != null) {
      Navigator.of(context).pushNamed('/Tabs', arguments: 2);
    }
  }

  Future setPref() async {
    AppOpened().saveOpenState();
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = OnboardingItems.loadOnboardingItem().length;
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.96),
      body: PageView.builder(
        itemCount: totalPages,
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          OnboardingItem oi = OnboardingItems.loadOnboardingItem()[index];
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: new BoxDecoration(
              color: const Color(0xFFCC00FF),
              gradient: LinearGradient(
                colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
              ),
              image: new DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: new AssetImage(
                  oi.image,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        child: Image(image: AssetImage('img/logo.png'))),
                    GestureDetector(
                      onTap: () {
                        setPref();
                        Navigator.of(context).pushNamed('/SignIn');
                      },
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 15, right: 15, bottom: 35),
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(children: [
                    Text(
                      oi.title,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(oi.subtitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ]),
                ),
                index == (totalPages - 1)
                    ? MaterialButton(
                        onPressed: () {
                          setPref();
                          Navigator.of(context)
                              .pushNamed('/Tabs', arguments: 2);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 17,
                          ),
                          child: Text("Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[350],
                              offset: Offset(0.0, 1.5),
                              blurRadius: 1.5,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            print("this is slideIndex: $_current");
                            controller.animateToPage(_current + 1,
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.linear);
                          },
                          icon: Icon(Icons.arrow_forward_ios,
                              color: Color(0xFFCC00FF)),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 10,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: totalPages,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: EdgeInsets.all(2),
                          child: Container(
                            width: index == i ? 30 : 20,
                            color: index == i ? Colors.white70 : Colors.white30,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
