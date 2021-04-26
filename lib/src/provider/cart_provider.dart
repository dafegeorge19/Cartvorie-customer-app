import 'package:cartvorie/src/models/CartModel.dart';
import 'package:flutter_riverpod/all.dart';

final cartListProvider = StateNotifierProvider((ref) => CartList([]));

final cartProvider = Provider((ref) => ref.watch(cartListProvider.state));

final cartCountProvider = Provider<int>((ref) {
  int count = 0;
  count = ref.watch(cartListProvider.state).length;
  return count;
});

final cartSubTotalProvider = Provider<double>((ref) {
  final cartList = ref.watch(cartListProvider.state);
  double subTotal = 0.0;
  cartList.forEach((e) {
    subTotal += double.parse(e.price) * e.quantity;
  });
  return subTotal;
});

final taxProvider = Provider<double>((ref) {
  final cartList = ref.watch(cartListProvider.state);
  double subTotal = 0.0;
  cartList.forEach((e) {
    subTotal += double.parse(e.price) * e.quantity;
  });
  double tax =   subTotal*.13;
  return tax;
});

final deliveryServiceFeeProvider = Provider<double>((ref) {
  final cartList = ref.watch(cartListProvider.state);
  double subTotal = 0.0;
  cartList.forEach((e) {
    subTotal += double.parse(e.price) * e.quantity;
  });
  double deliveryServiceFee = .08*subTotal;
  return deliveryServiceFee;
});

final cartTotalProvider = Provider<double>((ref) {
  final cartList = ref.watch(cartListProvider.state);
  double subTotal = 0.0;
  cartList.forEach((e) {
    subTotal += double.parse(e.price) * e.quantity;
  });
  double total = subTotal + 5;
  return total;
});
