import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/review.dart';
import 'package:flutter/material.dart';

class ReviewItemWidget extends StatelessWidget {
  final ProductReview review;

  ReviewItemWidget({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.2),
              offset: Offset(0, 4),
              blurRadius: 7)
        ],
      ),
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 10,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  review.review,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                review.reviewerName.toUpperCase(),
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    UiIcons.calendar,
                    color: Theme.of(context).focusColor,
                    size: 14,
                  ),
                  SizedBox(width: 3),
                  Text(
                    review.updatedAt.toString(),
                    style: Theme.of(context).textTheme.caption,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
