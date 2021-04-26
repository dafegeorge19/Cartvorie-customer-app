import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/config/validators.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:cartvorie/src/services/authentication_service.dart';
import 'package:cartvorie/src/widgets/SocialMediaWidget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SignInWidget extends HookWidget {
  final _loginKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final _showPassword = useState(false);
    final authenticator = useProvider(authenticationProvider.state);
    //login controllers
    final loginEmailController = useTextEditingController();
    final passwordController = useTextEditingController();
    // end
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    var login = () {
      final form = _loginKey.currentState;
      print(
          'email:${loginEmailController.text} password: ${passwordController.text}');
      if (form.validate()) {
        form.save();
        final Future<Map<String, dynamic>> successfulMessage = context
            .read(authenticationProvider)
            .login(loginEmailController.text, passwordController.text);

        successfulMessage.then((response) {
          if (response['status']) {
            UserModel data = response['user'];
            context.read(userPreferenceProvider).saveUser(data);
            Navigator.of(context).popAndPushNamed('/Tabs', arguments: 1);
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        print("form is invalid");
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
                  margin: EdgeInsets.symmetric(vertical: 65, horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 26, horizontal: 30),
                  margin: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Form(
                    key: _loginKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 16),
                        Text('Sign In',
                            style: Theme.of(context).textTheme.display3),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: loginEmailController,
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
                          validator: (value) =>
                              value.isEmpty ? "Please enter password" : null,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          controller: passwordController,
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
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot your password ?',
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        SizedBox(height: 16),
                        authenticator == AuthStatus.Authenticating
                            ? loading
                            : FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 70),
                                onPressed: login,
                                child: Text(
                                  'Login',
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
                Navigator.of(context).popAndPushNamed('/SignUp');
              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    TextSpan(text: 'Don\'t have an account ?'),
                    TextSpan(
                        text: ' Sign Up',
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
