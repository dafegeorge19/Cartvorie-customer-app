// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

class NotificationModel {
  NotificationModel({
    this.data,
    this.status,
    this.message,
  });

  List<NotificationData> data;
  String status;
  String message;

  factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    data: List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class NotificationData {
  NotificationData({
    this.type,
    this.message,
    this.notificatinType,
    this.id,
    this.date,
  });

  Type type;
  String message;
  String notificatinType;
  String id;
  String date;

  factory NotificationData.fromRawJson(String str) => NotificationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    type: json["type"],
    message: json["message"],
    notificatinType: json["notificatin_type"],
    id: json["id"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "message": message,
    "notificatin_type": notificatinType,
    "id": id,
    "date": date,
  };
}






