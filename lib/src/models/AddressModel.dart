// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

class AddressModel {
  AddressModel({
    this.id,
    this.streetAddress,
  });

  int id;

  String streetAddress;

  factory AddressModel.fromRawJson(String str) => AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    streetAddress: json["street_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "street_address": streetAddress,
  };
}

