import 'package:flutter/material.dart';

class NotSignedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You are not Signed In'),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
                child: Text('Sign In'),
                onPressed: () => Navigator.pushNamed(context, '/SignIn'))
          ],
        ),
      ),
    );
  }
}

class NotSignedInWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                child: Text('Sign In'),
                onPressed: () => Navigator.pushNamed(context, '/SignIn'))
          ],
        ),
      ),
    );
  }
}
