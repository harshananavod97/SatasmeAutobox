import 'dart:convert';

MyAdModel myAdModelFromJson(String str) => MyAdModel.fromJson(json.decode(str));

String myAdModelToJson(MyAdModel data) => json.encode(data.toJson());

class MyAdModel {
  String stat;
  List<Ad> ad;

  MyAdModel({
    required this.stat,
    required this.ad,
  });

  factory MyAdModel.fromJson(Map<String, dynamic> json) => MyAdModel(
        stat: json["stat"],
        ad: List<Ad>.from(json["ad"].map((x) => Ad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "ad": List<dynamic>.from(ad.map((x) => x.toJson())),
      };
}

class Ad {
  String name;
  String adTitle;
  int adPrice;
  int id;
  String vtName;
  String adDistrict;
  String adDescription;
  String adCity;
  DateTime createdAt;
  int adNumber;
  int isTopId;
  int brandsId;
  int modelsId;
  String adsCondition;
  int adsCustomersId;
  int adViewCount;
  int negotiable;
  int status;

  Ad({
    required this.name,
    required this.adTitle,
    required this.adPrice,
    required this.id,
    required this.vtName,
    required this.adDistrict,
    required this.adDescription,
    required this.adCity,
    required this.createdAt,
    required this.adNumber,
    required this.isTopId,
    required this.brandsId,
    required this.modelsId,
    required this.adsCondition,
    required this.adsCustomersId,
    required this.adViewCount,
    required this.negotiable,
    required this.status,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        name: json["name"],
        adTitle: json["ad_title"],
        adPrice: json["ad_price"],
        id: json["id"],
        vtName: json["vt_name"],
        adDistrict: json["ad_district"],
        adDescription: json["ad_description"],
        adCity: json["ad_city"],
        createdAt: DateTime.parse(json["created_at"]),
        adNumber: json["ad_number"],
        isTopId: json["is_top_id"],
        brandsId: json["brands_id"],
        modelsId: json["models_id"],
        adsCondition: json["ads_condition"],
        adsCustomersId: json["ads_customers_id"],
        adViewCount: json["ad_view_count"],
        negotiable: json["negotiable"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ad_title": adTitle,
        "ad_price": adPrice,
        "id": id,
        "vt_name": vtName,
        "ad_district": adDistrict,
        "ad_description": adDescription,
        "ad_city": adCity,
        "created_at": createdAt.toIso8601String(),
        "ad_number": adNumber,
        "is_top_id": isTopId,
        "brands_id": brandsId,
        "models_id": modelsId,
        "ads_condition": adsCondition,
        "ads_customers_id": adsCustomersId,
        "ad_view_count": adViewCount,
        "negotiable": negotiable,
        "status": status,
      };
}
