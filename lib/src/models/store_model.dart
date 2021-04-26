// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

class StoreModel {
  StoreModel({
    this.data,
    this.links,
    this.meta,
  });

  List<StoreData> data;
  Links links;
  Meta meta;

  factory StoreModel.fromRawJson(String str) =>
      StoreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        data: List<StoreData>.from(
            json["data"].map((x) => StoreData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class StoreData {
  StoreData({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.openingTime,
    this.closingTime,
    this.longitude,
    this.latitude,
    this.addresses,
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
  Addresses addresses;
  List<StoreImageData> images;

  factory StoreData.fromRawJson(String str) =>
      StoreData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        addresses: Addresses.fromJson(json["addresses"]),
        images: List<StoreImageData>.from(
            json["images"].map((x) => StoreImageData.fromJson(x))),
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
        "addresses": addresses.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Addresses {
  Addresses({
    this.id,
    this.state,
    this.area,
    this.streetAddress,
  });

  int id;
  Area state;
  Area area;
  String streetAddress;

  factory Addresses.fromRawJson(String str) =>
      Addresses.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        id: json["id"],
        state: Area.fromJson(json["state"]),
        area: Area.fromJson(json["area"]),
        streetAddress: json["street_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state.toJson(),
        "area": area.toJson(),
        "street_address": streetAddress,
      };
}

class Area {
  Area({
    this.id,
    this.name,
    this.stateId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
  });

  int id;
  String name;
  String stateId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String categoryId;

  factory Area.fromRawJson(String str) => Area.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"] == null ? null : json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId == null ? null : stateId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category_id": categoryId == null ? null : categoryId,
      };
}

class StoreImageData {
  StoreImageData({
    this.id,
    this.name,
    this.original,
    this.thumbnails,
  });

  int id;
  String name;
  String original;
  PurpleThumbnails thumbnails;

  factory StoreImageData.fromRawJson(String str) =>
      StoreImageData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreImageData.fromJson(Map<String, dynamic> json) => StoreImageData(
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
  String medium;
  String large;

  factory PurpleThumbnails.fromRawJson(String str) =>
      PurpleThumbnails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

class FluffyThumbnails {
  FluffyThumbnails({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  dynamic medium;
  String large;

  factory FluffyThumbnails.fromRawJson(String str) =>
      FluffyThumbnails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

class Store {
  Store({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.stateId,
    this.areaId,
    this.openingTime,
    this.closingTime,
    this.streetAddress,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.longitude,
    this.latitude,
  });

  int id;
  Name name;
  Slug slug;
  Description description;
  String stateId;
  String areaId;
  String openingTime;
  String closingTime;
  StreetAddress streetAddress;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  dynamic longitude;
  dynamic latitude;

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: nameValues.map[json["name"]],
        slug: slugValues.map[json["slug"]],
        description: descriptionValues.map[json["description"]],
        stateId: json["state_id"],
        areaId: json["area_id"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        streetAddress: streetAddressValues.map[json["street_address"]],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "slug": slugValues.reverse[slug],
        "description": descriptionValues.reverse[description],
        "state_id": stateId,
        "area_id": areaId,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "street_address": streetAddressValues.reverse[streetAddress],
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "longitude": longitude,
        "latitude": latitude,
      };
}

enum Description {
  GRAND_MALL_GOOD_STORE_DESCRIPTION_HERE,
  WE_SELL_ONLY_QUALITY_AFRICAN_FOOD_STUFFS,
  OUR_STORE_IS_THE_BEST_FOR_AFRICAN_AND_WEST_INDIES_FOOD_MARKET,
  QUALITY_AFRICAN_STORE
}

final descriptionValues = EnumValues({
  "grand mall good store description here":
      Description.GRAND_MALL_GOOD_STORE_DESCRIPTION_HERE,
  "Our Store is the best for African and West indies food market":
      Description.OUR_STORE_IS_THE_BEST_FOR_AFRICAN_AND_WEST_INDIES_FOOD_MARKET,
  "Quality African Store": Description.QUALITY_AFRICAN_STORE,
  "We sell only quality African Food stuffs":
      Description.WE_SELL_ONLY_QUALITY_AFRICAN_FOOD_STUFFS
});

enum Name {
  MOSAIC_AFRICAN_FOOD,
  NAOMI_AFRICAN_FOOD_MARKET,
  SIMI_AFRICAN_FOOD,
  ENVY_AFRICAN_SUPERMARKET
}

final nameValues = EnumValues({
  "Envy African Supermarket": Name.ENVY_AFRICAN_SUPERMARKET,
  "Mosaic African Food": Name.MOSAIC_AFRICAN_FOOD,
  "Naomi African Food Market": Name.NAOMI_AFRICAN_FOOD_MARKET,
  "Simi African Food": Name.SIMI_AFRICAN_FOOD
});

enum Slug { GRAND_MALL, ELIJAH_OKOKON, IOU_MARKET, ENVY_GROCERY_SUPERMARKET }

final slugValues = EnumValues({
  "elijah-okokon": Slug.ELIJAH_OKOKON,
  "envy-grocery-supermarket": Slug.ENVY_GROCERY_SUPERMARKET,
  "grand-mall": Slug.GRAND_MALL,
  "iou-market": Slug.IOU_MARKET
});

enum StreetAddress {
  STORE_STREET_ADDRESS,
  THE_3226_WESTON_ROAD_TORONTO,
  THE_144_EDDY_STONE_TORONTO,
  THE_2111_WESTON_ROAD_TORONTO
}

final streetAddressValues = EnumValues({
  "store street address": StreetAddress.STORE_STREET_ADDRESS,
  "144 Eddy Stone, Toronto": StreetAddress.THE_144_EDDY_STONE_TORONTO,
  "2111 Weston Road, Toronto": StreetAddress.THE_2111_WESTON_ROAD_TORONTO,
  "3226 Weston Road, Toronto": StreetAddress.THE_3226_WESTON_ROAD_TORONTO
});

enum BillingFirstnameEnum { CARTVORIE_BUYER, CARTVORIE }

final billingFirstnameEnumValues = EnumValues({
  "Cartvorie": BillingFirstnameEnum.CARTVORIE,
  "Cartvorie Buyer": BillingFirstnameEnum.CARTVORIE_BUYER
});

enum BillingLastnameEnum { DMATRIX, BUYER }

final billingLastnameEnumValues = EnumValues({
  "Buyer": BillingLastnameEnum.BUYER,
  "Dmatrix": BillingLastnameEnum.DMATRIX
});

enum OrderType { EMPTY, PICKUP }

final orderTypeValues =
    EnumValues({"": OrderType.EMPTY, "pickup": OrderType.PICKUP});

enum Status { PENDING, ASSIGNED }

final statusValues =
    EnumValues({"Assigned": Status.ASSIGNED, "pending": Status.PENDING});

class Points {
  Points({
    this.id,
    this.userId,
    this.purchaseCount,
    this.totalPoint,
    this.usedPoint,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String userId;
  String purchaseCount;
  String totalPoint;
  String usedPoint;
  String amount;
  DateTime createdAt;
  DateTime updatedAt;

  factory Points.fromRawJson(String str) => Points.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Points.fromJson(Map<String, dynamic> json) => Points(
        id: json["id"],
        userId: json["user_id"],
        purchaseCount: json["purchase_count"],
        totalPoint: json["total_point"],
        usedPoint: json["used_point"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "purchase_count": purchaseCount,
        "total_point": totalPoint,
        "used_point": usedPoint,
        "amount": amount,
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
  dynamic next;

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
