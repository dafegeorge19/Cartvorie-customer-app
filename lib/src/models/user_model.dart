// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  UserModel({
    this.user,
    this.accessToken,
    this.status,
  });

  UserData user;
  String accessToken;
  bool status;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: UserData.fromJson(json["user"]),
        accessToken: json["access_token"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
        "status": status,
      };
}

class UserData {
  UserData({
    this.userId,
    this.firstname,
    this.lastname,
    this.accountType,
    this.email,
    this.phoneNumber,
    this.images,
    this.orders,
    this.addresses,
    this.messages,
    this.settings,
    this.wallets,
    this.points,
    this.favourites,
    this.reviews,
    this.cards,
    this.driverDetail,
    this.products,
    this.dateTime,
  });

  int userId;
  String firstname;
  String lastname;
  String accountType;
  String email;
  dynamic phoneNumber;
  List<dynamic> images;
  List<dynamic> orders;
  List<dynamic> addresses;
  List<dynamic> messages;
  Settings settings;
  List<dynamic> wallets;
  dynamic points;
  List<dynamic> favourites;
  List<Review> reviews;
  List<dynamic> cards;
  dynamic driverDetail;
  List<dynamic> products;
  DateTime dateTime;

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        accountType: json["account_type"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
        messages: List<dynamic>.from(json["messages"].map((x) => x)),
        settings: Settings.fromJson(json["settings"]),
        wallets: List<dynamic>.from(json["wallets"].map((x) => x)),
        points: json["points"],
        favourites: List<dynamic>.from(json["favourites"].map((x) => x)),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        cards: List<dynamic>.from(json["cards"].map((x) => x)),
        driverDetail: json["driver_detail"],
        products: List<dynamic>.from(json["products"].map((x) => x)),
        dateTime: DateTime.parse(json["date_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": userId,
        "firstname": firstname,
        "lastname": lastname,
        "account_type": accountType,
        "email": email,
        "phone_number": phoneNumber,
        "images": List<dynamic>.from(images.map((x) => x)),
        "orders": List<dynamic>.from(orders.map((x) => x)),
        "addresses": List<dynamic>.from(addresses.map((x) => x)),
        "messages": List<dynamic>.from(messages.map((x) => x)),
        "settings": settings.toJson(),
        "wallets": List<dynamic>.from(wallets.map((x) => x)),
        "points": points,
        "favourites": List<dynamic>.from(favourites.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "cards": List<dynamic>.from(cards.map((x) => x)),
        "driver_detail": driverDetail,
        "products": List<dynamic>.from(products.map((x) => x)),
        "date_time": dateTime.toIso8601String(),
      };
}

class Review {
  Review({
    this.id,
    this.productId,
    this.userId,
    this.rating,
    this.reviewerName,
    this.reviewerEmail,
    this.reviewerType,
    this.review,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String productId;
  String userId;
  String rating;
  String reviewerName;
  String reviewerEmail;
  String reviewerType;
  String review;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        rating: json["rating"],
        reviewerName: json["reviewer_name"],
        reviewerEmail: json["reviewer_email"],
        reviewerType: json["reviewer_type"],
        review: json["review"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "rating": rating,
        "reviewer_name": reviewerName,
        "reviewer_email": reviewerEmail,
        "reviewer_type": reviewerType,
        "review": review,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Settings {
  Settings({
    this.id,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.securityCode,
  });

  int id;
  String userId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String securityCode;

  factory Settings.fromRawJson(String str) =>
      Settings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        id: json["id"],
        userId: json["user_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        securityCode: json["security_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "security_code": securityCode,
      };
}
