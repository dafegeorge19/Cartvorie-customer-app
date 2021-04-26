import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/widgets/ReviewItemWidget.dart';
import 'package:flutter/material.dart';

class ReviewsListWidget extends StatelessWidget {
 final List<ProductReview> reviewsList ;
  ReviewsListWidget({
    Key key,  this.reviewsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reviewsList.isEmpty?Center(child: Text('This product Has no review'),): ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemBuilder: (context, index) {
        return ReviewItemWidget(review: reviewsList.elementAt(index));
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 10,
        );
      },
      itemCount: reviewsList.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
