import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: <Widget>[
            _gestureClicker("Grocery Delivery", "/Brands"),
            _gestureClicker("Pickup & Delivery", "/PickupDelivery"),
            _gestureClicker("Stores", "/Brands")
          ],
        ),
      ),
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
