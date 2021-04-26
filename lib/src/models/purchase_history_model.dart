// To parse this JSON data, do
//
//     final purchaseHistoryModel = purchaseHistoryModelFromJson(jsonString);

import 'dart:convert';

List<PurchaseHistoryModel> purchaseHistoryModelFromJson(String str) =>
    List<PurchaseHistoryModel>.from(
        json.decode(str).map((x) => PurchaseHistoryModel.fromJson(x)));

String purchaseHistoryModelToJson(List<PurchaseHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchaseHistoryModel {
  PurchaseHistoryModel({
    this.id,
    this.userId,
    this.billingFirstname,
    this.billingLastname,
    this.billingStateId,
    this.billingAreaId,
    this.billingStreetAddress,
    this.billingPhoneNumber,
    this.billingEmail,
    this.deliveryFirstname,
    this.deliveryLastname,
    this.deliveryStateId,
    this.deliveryAreaId,
    this.deliveryStreetAddress,
    this.deliveryPhoneNumber,
    this.deliveryEmail,
    this.orderNote,
    this.totalProductsAmount,
    this.deliveryFee,
    this.totalProductsWeight,
    this.orderType,
    this.deliveredAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  int id;
  String userId;
  String billingFirstname;
  String billingLastname;
  String billingStateId;
  String billingAreaId;
  String billingStreetAddress;
  String billingPhoneNumber;
  String billingEmail;
  String deliveryFirstname;
  String deliveryLastname;
  String deliveryStateId;
  String deliveryAreaId;
  String deliveryStreetAddress;
  String deliveryPhoneNumber;
  String deliveryEmail;
  dynamic orderNote;
  String totalProductsAmount;
  String deliveryFee;
  String totalProductsWeight;
  String orderType;
  dynamic deliveredAt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String status;

  factory PurchaseHistoryModel.fromJson(Map<String, dynamic> json) =>
      PurchaseHistoryModel(
        id: json["id"],
        userId: json["user_id"],
        billingFirstname: json["billing_firstname"],
        billingLastname: json["billing_lastname"],
        billingStateId: json["billing_state_id"],
        billingAreaId: json["billing_area_id"],
        billingStreetAddress: json["billing_street_address"],
        billingPhoneNumber: json["billing_phone_number"],
        billingEmail: json["billing_email"],
        deliveryFirstname: json["delivery_firstname"],
        deliveryLastname: json["delivery_lastname"],
        deliveryStateId: json["delivery_state_id"],
        deliveryAreaId: json["delivery_area_id"],
        deliveryStreetAddress: json["delivery_street_address"],
        deliveryPhoneNumber: json["delivery_phone_number"],
        deliveryEmail: json["delivery_email"],
        orderNote: json["order_note"],
        totalProductsAmount: json["total_products_amount"],
        deliveryFee: json["delivery_fee"],
        totalProductsWeight: json["total_products_weight"],
        orderType: json["order_type"],
        deliveredAt: json["delivered_at"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "billing_firstname": billingFirstname,
        "billing_lastname": billingLastname,
        "billing_state_id": billingStateId,
        "billing_area_id": billingAreaId,
        "billing_street_address": billingStreetAddress,
        "billing_phone_number": billingPhoneNumber,
        "billing_email": billingEmail,
        "delivery_firstname": deliveryFirstname,
        "delivery_lastname": deliveryLastname,
        "delivery_state_id": deliveryStateId,
        "delivery_area_id": deliveryAreaId,
        "delivery_street_address": deliveryStreetAddress,
        "delivery_phone_number": deliveryPhoneNumber,
        "delivery_email": deliveryEmail,
        "order_note": orderNote,
        "total_products_amount": totalProductsAmount,
        "delivery_fee": deliveryFee,
        "total_products_weight": totalProductsWeight,
        "order_type": orderType,
        "delivered_at": deliveredAt,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
      };
}
