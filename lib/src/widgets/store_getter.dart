import 'package:cartvorie/src/provider/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'StoreGridWidget.dart';

class StoresGetter extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final stores = useProvider(getAllStoresProvider);

    return Container(
      // child: stores.when(data: (stores)=>StoreGridWidget(storesList: stores), loading: ()=>CircularProgressIndicator(), error: (e,s)=>Text('error ${e.toString()}')),
    );
  }
}
