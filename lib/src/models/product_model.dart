// // To parse this JSON data, do
// //
// // final productModel = productModelFromJson(jsonString);

// import 'dart:convert';

// class ProductModel {
//   ProductModel({
//     this.data,
//     this.links,
//     this.meta,
//   });

//   List<ProductData> data;
//   Links links;
//   Meta meta;

//   factory ProductModel.fromRawJson(String str) =>
//       ProductModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//         data: List<ProductData>.from(
//             json["data"].map((x) => ProductData.fromJson(x))),
//         links: Links.fromJson(json["links"]),
//         meta: Meta.fromJson(json["meta"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "links": links.toJson(),
//         "meta": meta.toJson(),
//       };
// }

// class ProductData {
//   ProductData({
//     this.id,
//     this.name,
//     this.weight,
//     this.price,
//     this.salesPrice,
//     this.description,
//     this.slug,
//     this.createdAt,
//     this.updatedAt,
//     this.color,
//     this.stock,
//     this.reviews,
//     this.images,
//     this.store,
//     this.category,
//     this.subCategory,
//   });

//   int id;
//   String name;
//   String weight;
//   String price;
//   String salesPrice;
//   dynamic description;
//   String slug;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String color;
//   String stock;
//   List<ProductReview> reviews;
//   List<Image> images;
//   Store store;
//   Category category;
//   SubCategory subCategory;

//   factory ProductData.fromRawJson(String str) =>
//       ProductData.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
//         id: json["id"],
//         name: json["name"],
//         weight: json["weight"],
//         price: json["price"],
//         salesPrice: json["sales_price"],
//         description: json["description"],
//         slug: json["slug"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         color: json["color"],
//         stock: json["stock"],
//         reviews: List<ProductReview>.from(
//             json["reviews"].map((x) => ProductReview.fromJson(x))),
//         images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
//         store: Store.fromJson(json["store"]),
//         category: Category.fromJson(json["category"]),
//         subCategory: SubCategory.fromJson(json["sub_category"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "weight": weight,
//         "price": price,
//         "sales_price": salesPrice,
//         "description": description,
//         "slug": slug,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "color": color,
//         "stock": stock,
//         "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
//         "images": List<dynamic>.from(images.map((x) => x.toJson())),
//         "store": store.toJson(),
//         "category": category.toJson(),
//         "sub_category": subCategory.toJson(),
//       };
// }

// class Category {
//   Category({
//     this.id,
//     this.name,
//     this.slug,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.description,
//   });

//   int id;
//   String name;
//   String slug;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic description;

//   factory Category.fromRawJson(String str) =>
//       Category.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: json["name"],
//         slug: json["slug"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         description: json["description"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "slug": slug,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "description": description,
//       };
// }

// class Image {
//   Image({
//     this.id,
//     this.name,
//     this.original,
//     this.thumbnails,
//   });

//   int id;
//   String name;
//   String original;
//   Thumbnails thumbnails;

//   factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         name: json["name"],
//         original: json["original"],
//         thumbnails: Thumbnails.fromJson(json["thumbnails"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "original": original,
//         "thumbnails": thumbnails.toJson(),
//       };
// }

// class Thumbnails {
//   Thumbnails({
//     this.small,
//     this.medium,
//     this.large,
//   });

//   String small;
//   dynamic medium;
//   String large;

//   factory Thumbnails.fromRawJson(String str) =>
//       Thumbnails.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
//         small: json["small"],
//         medium: json["medium"],
//         large: json["large"],
//       );

//   Map<String, dynamic> toJson() => {
//         "small": small,
//         "medium": medium,
//         "large": large,
//       };
// }

// class MediumClass {
//   MediumClass();

//   factory MediumClass.fromRawJson(String str) =>
//       MediumClass.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory MediumClass.fromJson(Map<String, dynamic> json) => MediumClass();

//   Map<String, dynamic> toJson() => {};
// }

// class ProductReview {
//   ProductReview({
//     this.id,
//     this.productId,
//     this.userId,
//     this.rating,
//     this.reviewerName,
//     this.reviewerEmail,
//     this.reviewerType,
//     this.review,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   String productId;
//   String userId;
//   String rating;
//   String reviewerName;
//   String reviewerEmail;
//   String reviewerType;
//   String review;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory ProductReview.fromRawJson(String str) =>
//       ProductReview.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
//         id: json["id"],
//         productId: json["product_id"],
//         userId: json["user_id"],
//         rating: json["rating"],
//         reviewerName: json["reviewer_name"],
//         reviewerEmail: json["reviewer_email"],
//         reviewerType: json["reviewer_type"],
//         review: json["review"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "user_id": userId,
//         "rating": rating,
//         "reviewer_name": reviewerName,
//         "reviewer_email": reviewerEmail,
//         "reviewer_type": reviewerType,
//         "review": review,
//         "status": status,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// class Store {
//   Store({
//     this.id,
//     this.name,
//     this.slug,
//     this.description,
//     this.stateId,
//     this.areaId,
//     this.openingTime,
//     this.closingTime,
//     this.streetAddress,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.userId,
//     this.longitude,
//     this.latitude,
//   });

//   int id;
//   String name;
//   String slug;
//   String description;
//   String stateId;
//   String areaId;
//   String openingTime;
//   String closingTime;
//   String streetAddress;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String userId;
//   dynamic longitude;
//   dynamic latitude;

//   factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Store.fromJson(Map<String, dynamic> json) => Store(
//         id: json["id"],
//         name: json["name"],
//         slug: json["slug"],
//         description: json["description"],
//         stateId: json["state_id"],
//         areaId: json["area_id"],
//         openingTime: json["opening_time"],
//         closingTime: json["closing_time"],
//         streetAddress: json["street_address"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         userId: json["user_id"],
//         longitude: json["longitude"],
//         latitude: json["latitude"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "slug": slug,
//         "description": description,
//         "state_id": stateId,
//         "area_id": areaId,
//         "opening_time": openingTime,
//         "closing_time": closingTime,
//         "street_address": streetAddress,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "user_id": userId,
//         "longitude": longitude,
//         "latitude": latitude,
//       };
// }

// class SubCategory {
//   SubCategory({
//     this.id,
//     this.name,
//     this.categoryId,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   String name;
//   String categoryId;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory SubCategory.fromRawJson(String str) =>
//       SubCategory.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
//         id: json["id"],
//         name: json["name"],
//         categoryId: json["category_id"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "category_id": categoryId,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// class Links {
//   Links({
//     this.first,
//     this.last,
//     this.prev,
//     this.next,
//   });

//   String first;
//   String last;
//   dynamic prev;
//   dynamic next;

//   factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//         first: json["first"],
//         last: json["last"],
//         prev: json["prev"],
//         next: json["next"],
//       );

//   Map<String, dynamic> toJson() => {
//         "first": first,
//         "last": last,
//         "prev": prev,
//         "next": next,
//       };
// }

// class Meta {
//   Meta({
//     this.currentPage,
//     this.from,
//     this.lastPage,
//     this.path,
//     this.perPage,
//     this.to,
//     this.total,
//   });

//   int currentPage;
//   int from;
//   int lastPage;
//   String path;
//   int perPage;
//   int to;
//   int total;

//   factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         currentPage: json["current_page"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         path: json["path"],
//         perPage: json["per_page"],
//         to: json["to"],
//         total: json["total"],
//       );

//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "from": from,
//         "last_page": lastPage,
//         "path": path,
//         "per_page": perPage,
//         "to": to,
//         "total": total,
//       };
// }
// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.data,
    this.links,
    this.meta,
  });

  List<ProductData> data;
  Links links;
  Meta meta;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: List<ProductData>.from(
            json["data"].map((x) => ProductData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class ProductData {
  ProductData({
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
  String color;
  String stock;
  List<ProductReview> reviews;
  List<Image> images;
  Store store;
  Category category;
  SubCategory subCategory;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        name: json["name"],
        weight: json["weight"],
        price: json["price"],
        salesPrice: json["sales_price"],
        description: json["description"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        color: json["color"],
        stock: json["stock"],
        reviews: List<ProductReview>.from(
            json["reviews"].map((x) => ProductReview.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
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
        "description": description,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "color": color,
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
  String name;
  String slug;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic description;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "description": description,
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

class ProductReview {
  ProductReview({
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

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
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
  List<Image> images;

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
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
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
