import 'package:flutter/foundation.dart';

class CardModel{
  String amount;
  String currency;
  String cardNumber;
  String expiryDate;

  CardModel({
    @required this.amount,
    @required this.currency,
    @required this.cardNumber,
    @required this.expiryDate,
  });

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return new CardModel(
      amount: map['amount'] as String,
      currency: map['currency'] as String,
      cardNumber: map['cardNumber'] as String,
      expiryDate: map['expiryDate'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'amount': this.amount,
      'currency': this.currency,
      'cardNumber': this.cardNumber,
      'expiryDate': this.expiryDate,
    } as Map<String, dynamic>;
  }
}