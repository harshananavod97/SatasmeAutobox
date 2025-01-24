// To parse this JSON data, do
//
//     final latestAdsModel = latestAdsModelFromJson(jsonString);

import 'dart:convert';

LatestAdsModel latestAdsModelFromJson(String str) =>
    LatestAdsModel.fromJson(json.decode(str));

String latestAdsModelToJson(LatestAdsModel data) => json.encode(data.toJson());

class LatestAdsModel {
  String stat;
  List<Ad> ads;

  LatestAdsModel({
    required this.stat,
    required this.ads,
  });

  factory LatestAdsModel.fromJson(Map<String, dynamic> json) => LatestAdsModel(
        stat: json["stat"],
        ads: List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "ads": List<dynamic>.from(ads.map((x) => x.toJson())),
      };
}

class Ad {
  dynamic name;
  String adTitle;
  int adPrice;
  int id;
  String vtName;
  String adDistrict;
  String adCity;
  DateTime createdAt;
  int adNumber;
  int isTopId;

  Ad({
    required this.name,
    required this.adTitle,
    required this.adPrice,
    required this.id,
    required this.vtName,
    required this.adDistrict,
    required this.adCity,
    required this.createdAt,
    required this.adNumber,
    required this.isTopId,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        name: json["name"] ?? '',
        adTitle: json["ad_title"],
        adPrice: json["ad_price"],
        id: json["id"],
        vtName: json["vt_name"],
        adDistrict: json["ad_district"],
        adCity: json["ad_city"],
        createdAt: DateTime.parse(json["created_at"]),
        adNumber: json["ad_number"],
        isTopId: json["is_top_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ad_title": adTitle,
        "ad_price": adPrice,
        "id": id,
        "vt_name": vtName,
        "ad_district": adDistrict,
        "ad_city": adCity,
        "created_at": createdAt.toIso8601String(),
        "ad_number": adNumber,
        "is_top_id": isTopId,
      };
}
