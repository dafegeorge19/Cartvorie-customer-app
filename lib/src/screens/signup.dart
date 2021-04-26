import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/config/validators.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:cartvorie/src/provider/auth_provider.dart';
import 'package:cartvorie/src/services/authentication_service.dart';
import 'package:cartvorie/src/widgets/SocialMediaWidget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpWidget extends HookWidget {
  Widget build(BuildContext context) {
    final authValue = useProvider(authenticationProvider.state);

    var _showPassword = useState(false);
    final _registerKey = GlobalKey<FormState>();

    //registration controllers
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final registerEmailController = useTextEditingController();
    final registerPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    // end
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Signing up  ... Please wait")
      ],
    );
    var register = () {
      final form = _registerKey.currentState;
      if (form.validate()) {
        form.save();
        context
            .read(authenticationProvider)
            .register(
                firstNameController.text,
                lastNameController.text,
                registerEmailController.text,
                registerPasswordController.text,
                confirmPasswordController.text,
                'buyer')
            .then((response) {
          if (response['status']) {
            UserModel userData = response['user'];
            context.read(userPreferenceProvider).saveUser(userData);
            Navigator.of(context).pushNamed('/Tabs', arguments: 2);
          } else {
            Flushbar(
              title: "Registration Failed",
              message: response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('/Tabs', arguments: 1);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: _registerKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 16),
                        Text('Sign Up',
                            style: Theme.of(context).textTheme.display3),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: firstNameController,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: 'First Name',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              UiIcons.user_2,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: lastNameController,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              UiIcons.user_1,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: registerEmailController,
                          validator: validateEmail,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              UiIcons.envelope,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: registerPasswordController,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword.value,
                          decoration: new InputDecoration(
                            hintText: 'Password',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _showPassword.value = !_showPassword.value;
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(_showPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword.value,
                          decoration: new InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _showPassword.value = !_showPassword.value;
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(_showPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 36),
                        authValue == AuthStatus.Registering
                            ? loading
                            : FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 70),
                                onPressed: register,
                                child: Text(
                                  'Sign Up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .merge(
                                        TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                ),
                                color: Theme.of(context).accentColor,
                                shape: StadiumBorder(),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/SignIn');
              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    TextSpan(text: 'Already have an account ?'),
                    TextSpan(
                        text: ' Sign In',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
