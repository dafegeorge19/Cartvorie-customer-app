// To parse this JSON data, do
//
//     final ccrModel = ccrModelFromJson(jsonString);

import 'dart:convert';

List<CcrModel> ccrModelFromJson(String str) =>
    List<CcrModel>.from(json.decode(str).map((x) => CcrModel.fromJson(x)));

String ccrModelToJson(List<CcrModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CcrModel {
  CcrModel({
    this.id,
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.email,
    this.images,
    this.role,
    this.type,
    this.lastSeen,
    this.status,
  });

  int id;
  String firstname;
  String lastname;
  dynamic phoneNumber;
  String email;
  List<Image> images;
  String role;
  String type;
  bool lastSeen;
  String status;

  factory CcrModel.fromJson(Map<String, dynamic> json) => CcrModel(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        role: json["role"],
        type: json["type"],
        lastSeen: json["last_seen"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "phone_number": phoneNumber,
        "email": email,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "role": role,
        "type": type,
        "last_seen": lastSeen,
        "status": status,
      };
}

class Image {
  Image({
    this.id,
    this.name,
    this.original,
    this.thumbnails,
  });

  int id;
  String name;
  String original;
  Thumbnails thumbnails;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        name: json["name"],
        original: json["original"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "original": original,
        "thumbnails": thumbnails.toJson(),
      };
}

class Thumbnails {
  Thumbnails({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}
