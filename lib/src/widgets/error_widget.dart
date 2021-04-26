import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
class AppErrorWidget extends StatelessWidget {
  final String errorMessage;
  final RootProvider provider;
  const AppErrorWidget({Key key,@required this.errorMessage,@required this.provider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('$errorMessage'),
          FlatButton(onPressed: (){
            context.refresh(provider);
          }, child: Text('Tap to refresh'))
        ],
      ),
    );
  }
}
