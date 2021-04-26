import 'package:cartvorie/src/widgets/gradientButton.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final kInitialPosition = LatLng(56.1304, 106.3468);
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 80;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios_rounded,
                color: Theme.of(context).hintColor),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "FAQ",
            style: Theme.of(context).textTheme.display1,
          ),
          actions: <Widget>[
            ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor),
            Container(
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
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 40),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Update Your Account Operations",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF7401E0),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Create a unique 6 digit security code for transactions.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
        ));
  }
}
