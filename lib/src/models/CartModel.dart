import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

class CartItem extends Equatable {
  final String name;
  final String price;
  final String image;
  final int productId;
  final int quantity;
  final int storeId;
  final String storeName;

  CartItem({
    this.productId,
    this.price,
    this.image,
    this.name,
    this.quantity,
    this.storeId,
    this.storeName,
  });

  @override
  String toString() {
    return 'CartItem($name, $price, $quantity, $storeId, $storeName)';
  }

  @override
  List<Object> get props => [
        name,
        productId,
        image,
        price,
        quantity,
        storeId,
        storeName,
      ];
}

class CartList extends StateNotifier<List<CartItem>> {
  CartList(List<CartItem> cartList) : super(cartList ?? []);

  void add(CartItem cartItem) {
    // for(final cart in state){
    //   if(cart.productId == cartItem.productId){
    //     print('exist');
    //     edit(cartItem);
    //   }else{
    //     state = [
    //       ...state,cartItem,
    //     ];
    //   }
    // }
    print(cartItem);
    if (state.contains(cartItem)) {
      edit(cartItem);
    } else {
      state = [...state, cartItem];
    }
  }

  void edit(CartItem cartItem) {
    state = [
      for (final cart in state)
        if (cart.productId == cartItem.productId)
          CartItem(
              productId: cartItem.productId,
              price: cartItem.price,
              image: cartItem.image,
              quantity: cartItem.quantity < 1 ? 1 : cartItem.quantity,
              name: cartItem.name,
              storeId: cartItem.storeId,
              storeName: cartItem.storeName)
        else
          cart,
    ];
  }

  void remove(CartItem target) {
    state = state.where((cart) => cart.productId != target.productId).toList();
  }
}
