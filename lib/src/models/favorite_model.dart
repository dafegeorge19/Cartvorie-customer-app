// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

// FavoriteModel favoriteModelFromJson(String str) =>
//     FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

// class FavoriteModel {
//   FavoriteModel({
//     this.data,
//     this.links,
//     this.meta,
//   });

//   List<FavoriteModel> data;
//   Links links;
//   Meta meta;

//   factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
//         data: List<FavoriteModel>.from(
//             json["data"].map((x) => x == null ? null : FavoriteModel.fromJson(x))),
//         links: Links.fromJson(json["links"]),
//         meta: Meta.fromJson(json["meta"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data":
//             List<dynamic>.from(data.map((x) => x == null ? null : x.toJson())),
//         "links": links.toJson(),
//         "meta": meta.toJson(),
//       };
// }

class FavoriteModel {
  FavoriteModel({
    this.id,
    this.name,
    this.weight,
    this.price,
    this.salesPrice,
    this.description,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.stock,
    this.reviews,
    this.images,
    this.store,
    this.category,
    this.subCategory,
  });

  int id;
  String name;
  String weight;
  String price;
  String salesPrice;
  String description;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  Color color;
  String stock;
  List<Review> reviews;
  List<FavoriteModelImage> images;
  Store store;
  Category category;
  SubCategory subCategory;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        name: json["name"],
        weight: json["weight"],
        price: json["price"],
        salesPrice: json["sales_price"],
        description: json["description"] == null ? null : json["description"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        color: colorValues.map[json["color"]],
        stock: json["stock"],
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        images: List<FavoriteModelImage>.from(
            json["images"].map((x) => FavoriteModelImage.fromJson(x))),
        store: Store.fromJson(json["store"]),
        category: Category.fromJson(json["category"]),
        subCategory: SubCategory.fromJson(json["sub_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weight": weight,
        "price": price,
        "sales_price": salesPrice,
        "description": description == null ? null : description,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "color": colorValues.reverse[color],
        "stock": stock,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "store": store.toJson(),
        "category": category.toJson(),
        "sub_category": subCategory.toJson(),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  int id;
  Name name;
  Slug slug;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic description;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: nameValues.map[json["name"]],
        slug: slugValues.map[json["slug"]],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "slug": slugValues.reverse[slug],
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "description": description,
      };
}

enum Name { COSMETICS, BEAUTY, GROCERIES }

final nameValues = EnumValues({
  "Beauty": Name.BEAUTY,
  "Cosmetics": Name.COSMETICS,
  "Groceries": Name.GROCERIES
});

enum Slug { FASHION, BEAUTY, GROCERIES }

final slugValues = EnumValues({
  "beauty": Slug.BEAUTY,
  "fashion": Slug.FASHION,
  "groceries": Slug.GROCERIES
});

enum Color { RED, ORANGE, BLUE }

final colorValues =
    EnumValues({"blue": Color.BLUE, "orange": Color.ORANGE, "red": Color.RED});

class FavoriteModelImage {
  FavoriteModelImage({
    this.id,
    this.name,
    this.original,
    this.thumbnails,
  });

  int id;
  String name;
  String original;
  PurpleThumbnails thumbnails;

  factory FavoriteModelImage.fromJson(Map<String, dynamic> json) =>
      FavoriteModelImage(
        id: json["id"],
        name: json["name"],
        original: json["original"],
        thumbnails: PurpleThumbnails.fromJson(json["thumbnails"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "original": original,
        "thumbnails": thumbnails.toJson(),
      };
}

class PurpleThumbnails {
  PurpleThumbnails({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  dynamic medium;
  String large;

  factory PurpleThumbnails.fromJson(Map<String, dynamic> json) =>
      PurpleThumbnails(
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

class MediumClass {
  MediumClass();

  factory MediumClass.fromJson(Map<String, dynamic> json) => MediumClass();

  Map<String, dynamic> toJson() => {};
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
  ReviewerName reviewerName;
  ReviewerEmail reviewerEmail;
  ReviewerType reviewerType;
  String review;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        rating: json["rating"],
        reviewerName: reviewerNameValues.map[json["reviewer_name"]],
        reviewerEmail: reviewerEmailValues.map[json["reviewer_email"]],
        reviewerType: reviewerTypeValues.map[json["reviewer_type"]],
        review: json["review"],
        status: statusValues.map[json["status"]],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId == null ? null : userId,
        "rating": rating,
        "reviewer_name": reviewerNameValues.reverse[reviewerName],
        "reviewer_email": reviewerEmailValues.reverse[reviewerEmail],
        "reviewer_type": reviewerTypeValues.reverse[reviewerType],
        "review": review,
        "status": statusValues.reverse[status],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum ReviewerEmail {
  ABDULBASITSAEED619_GMAIL_COM,
  ABDULBASITSAEED_GMAIL_COM,
  DAFEGEORGE99_GMAIL_COM
}

final reviewerEmailValues = EnumValues({
  "abdulbasitsaeed619@gmail.com": ReviewerEmail.ABDULBASITSAEED619_GMAIL_COM,
  "abdulbasitsaeed@gmail.com": ReviewerEmail.ABDULBASITSAEED_GMAIL_COM,
  "dafegeorge99@gmail.com": ReviewerEmail.DAFEGEORGE99_GMAIL_COM
});

enum ReviewerName { ABDULBASIT_SAID_IBRAHIM, AUTHOR, GEORGE_DAFE }

final reviewerNameValues = EnumValues({
  "Abdulbasit Said Ibrahim": ReviewerName.ABDULBASIT_SAID_IBRAHIM,
  "author": ReviewerName.AUTHOR,
  "george dafe": ReviewerName.GEORGE_DAFE
});

enum ReviewerType { USER, GUEST }

final reviewerTypeValues =
    EnumValues({"guest": ReviewerType.GUEST, "user": ReviewerType.USER});

enum Status { PENDING }

final statusValues = EnumValues({"pending": Status.PENDING});

class Store {
  Store({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.openingTime,
    this.closingTime,
    this.longitude,
    this.latitude,
    this.streetAddress,
    this.images,
  });

  int id;
  String name;
  String slug;
  String description;
  String openingTime;
  String closingTime;
  dynamic longitude;
  dynamic latitude;
  String streetAddress;
  List<StoreImage> images;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        streetAddress: json["street_address"],
        images: List<StoreImage>.from(
            json["images"].map((x) => StoreImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "longitude": longitude,
        "latitude": latitude,
        "street_address": streetAddress,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class StoreImage {
  StoreImage({
    this.id,
    this.name,
    this.original,
    this.thumbnails,
  });

  int id;
  String name;
  String original;
  FluffyThumbnails thumbnails;

  factory StoreImage.fromJson(Map<String, dynamic> json) => StoreImage(
        id: json["id"],
        name: json["name"],
        original: json["original"],
        thumbnails: FluffyThumbnails.fromJson(json["thumbnails"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "original": original,
        "thumbnails": thumbnails.toJson(),
      };
}

class FluffyThumbnails {
  FluffyThumbnails({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory FluffyThumbnails.fromJson(Map<String, dynamic> json) =>
      FluffyThumbnails(
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

class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.categoryId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String categoryId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
