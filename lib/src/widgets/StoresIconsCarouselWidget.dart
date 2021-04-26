
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/widgets/PlaceHolder.dart';
import 'package:flutter/material.dart';

import 'StoreIconWidget.dart';

class BrandsIconsCarouselWidget extends StatefulWidget {
  StoreModel storesList;
  String heroTag;
  ValueChanged<String> onChanged;

  BrandsIconsCarouselWidget({Key key, this.storesList, this.heroTag, this.onChanged}) : super(key: key);

  @override
  _BrandsIconsCarouselWidgetState createState() => _BrandsIconsCarouselWidgetState();
}

class _BrandsIconsCarouselWidgetState extends State<BrandsIconsCarouselWidget> {
//  BrandsList _brandsList = new BrandsList();

  @override
  Widget build(BuildContext context) {
    return PlaceHolderWidget(placeHolderText: 'Store Carousel');
    // return SizedBox(
    //   height: 65,
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: <Widget>[
    //       Expanded(
    //         child: Container(
    //             decoration: BoxDecoration(
    //               color: Theme.of(context).accentColor.withOpacity(1),
    //               borderRadius: BorderRadius.only(bottomRight: Radius.circular(60), topRight: Radius.circular(60)),
    //             ),
    //             child: ListView.builder(
    //               shrinkWrap: true,
    //               itemCount: widget.storesList.list.length,
    //               itemBuilder: (context, index) {
    //                 double _marginLeft = 0;
    //                 (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
    //                 return BrandIconWidget(
    //                     heroTag: widget.heroTag,
    //                     marginLeft: _marginLeft,
    //                     store: widget.storesList.list.elementAt(index),
    //                     onPressed: (String id) {
    //                       setState(() {
    //                         widget.storesList.selectById(id);
    //                         widget.onChanged(id);
    //                       });
    //                     });
    //               },
    //               scrollDirection: Axis.horizontal,
    //             )),
    //       ),
    //       Container(
    //         width: 80,
    //         margin: EdgeInsets.only(left: 0),
    //         decoration: BoxDecoration(
    //           color: Theme.of(context).accentColor.withOpacity(1),
    //           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), topLeft: Radius.circular(60)),
    //         ),
    //         child: IconButton(
    //           onPressed: () {
    //             Navigator.of(context).pushNamed('/Brands');
    //           },
    //           icon: Icon(
    //             UiIcons.settings_2,
    //             size: 28,
    //             color: Theme.of(context).primaryColor,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
