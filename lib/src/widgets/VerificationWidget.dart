import 'package:cartvorie/config/ui_icons.dart';
import 'package:flutter/material.dart';

class VerificationWidget extends StatelessWidget {
  const VerificationWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(

          child: Column(
            children: [
              Text('Enter the Verification Code sent to your Email'),
              SizedBox(height: 24,),
              TextFormField(
                // controller: loginEmailController,
                // validator: validateEmail,
                style: TextStyle(color: Theme.of(context).accentColor),
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  hintText: 'Verification Code',
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                    TextStyle(color: Theme.of(context).accentColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).accentColor.withOpacity(0.2))),
                  focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  prefixIcon: Icon(
                    UiIcons.envelope,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
