import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/review_model.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/widgets/ProfileSettingsDialog.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cartvorie/config/validators.dart';
import 'package:cartvorie/src/provider/user_address_provider.dart';
import 'package:cartvorie/src/services/user_address_service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cartvorie/config/route_guard.dart';

class ReviewerHookWidget extends HookWidget {
  ReviewerHookWidget(this._product);

  final ProductData _product;
  ReviewModel reviewModel;

  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  final Map<String, dynamic> formData = {'review': null, 'rating': null};
  @override
  Widget build(BuildContext context) {
    final _user = useProvider(getUserProvider);
    return _user.when(
        data: (_user) {
          return RefreshIndicator(
            onRefresh: () =>
                context.refresh(getUserAddresses(_user.accessToken)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Icon(
                        UiIcons.chat_1,
                        color: Color(0xFF7401E0),
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Product Reviews',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  )),
                  GuardedWidget(
                    guardedWidget: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                titlePadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                title: Row(
                                  children: <Widget>[
                                    Icon(UiIcons.information,
                                        size: 14, color: Color(0xFF7401E0)),
                                    SizedBox(width: 10),
                                    Text(
                                      'Leave a review :',
                                      style: Theme.of(context)
                                          .textTheme
                                          .body2
                                          .merge(TextStyle(
                                              color: Color(0xFF7401E0),
                                              fontSize: 16)),
                                    )
                                  ],
                                ),
                                children: <Widget>[
                                  Form(
                                    key: _profileSettingsFormKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Rate this product :",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        RatingBar.builder(
                                          initialRating: 1,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          onRatingUpdate: (double rating) {
                                            formData['rating'] = rating;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        TextFormField(
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor),
                                          decoration: InputDecoration(
                                            labelText: 'Type Text Here...',
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            filled: true,
                                            fillColor: Colors.white70,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400],
                                                  width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                          ),
                                          onSaved: (String value) {
                                            formData['review'] = value;
                                          },
                                          keyboardType: TextInputType.text,
                                          maxLines: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      MaterialButton(
                                        onPressed: () =>
                                            _submitReview(_user, context),
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFFCC00FF),
                              Color(0xFF7401E0)
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[500],
                              offset: Offset(0.0, 1.5),
                              blurRadius: 1.5,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Text(
                            //   "Write a review",
                            //   style: TextStyle(
                            //     fontSize: 11,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            // SizedBox(width: 8),
                            Icon(Icons.edit, size: 16, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        loading: () => appLoader,
        error: (e, s) => Text('${e.toString()}'));
  }

  _submitReview(UserModel _user, BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    formData["product_id"] = _product.id;
    formData["author"] = _user.user.lastname + ' ' + _user.user.firstname;
    formData["email"] = _user.user.email;
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      final result = await context
          .read(userAddressProvider)
          .addReview(formData, _user.accessToken);
      await dialog.hide();
      // print(formData);
      if (result == null) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(
              content: Text(result.toString()),
              duration: new Duration(milliseconds: 1200),
            ))
            .closed
            //     .then((_) {
            //   context.refresh(getUserAddresses(_user.accessToken));
            // })
            .then((value) => Navigator.pop(context));
        // SnackBar(
        //   backgroundColor: Color(0xFF7401E0),
        //   content: Text(
        //     result.toString(),
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 16,
        //       fontWeight: FontWeight.w600,
        //     ),
        //     textAlign: TextAlign.center,
        //   ),
        //   duration: new Duration(milliseconds: 5000),
        // );
      }
    }
  }

  // Future<void> _submit(UserModel user) async {
  //   final result = await context
  //       .read(profileServiceProvider)
  //       .updateUserProfile(widget.user.accessToken, widget.user);
  //   print(result);
  //   Navigator.pop(context);
  // }

}
