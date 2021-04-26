// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  SettingsModel({
    this.id,
    this.driver,
    this.cartvorie,
    this.serviceBaseFee,
    this.kilometer,
    this.time,
    this.groceries,
    this.pickupDelivery,
    this.tC,
    this.returnPolicy,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String driver;
  String cartvorie;
  String serviceBaseFee;
  String kilometer;
  String time;
  String groceries;
  String pickupDelivery;
  String tC;
  String returnPolicy;
  DateTime createdAt;
  DateTime updatedAt;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        id: json["id"],
        driver: json["driver"],
        cartvorie: json["cartvorie"],
        serviceBaseFee: json["service_base_fee"],
        kilometer: json["kilometer"],
        time: json["time"],
        groceries: json["groceries"],
        pickupDelivery: json["pickup_delivery"],
        tC: json["t_c"],
        returnPolicy: json["return_policy"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver": driver,
        "cartvorie": cartvorie,
        "service_base_fee": serviceBaseFee,
        "kilometer": kilometer,
        "time": time,
        "groceries": groceries,
        "pickup_delivery": pickupDelivery,
        "t_c": tC,
        "return_policy": returnPolicy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
