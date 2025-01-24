// To parse this JSON data, do
//
//     final allAddModel = allAddModelFromJson(jsonString);

import 'dart:convert';

AllAddModel allAddModelFromJson(String str) =>
    AllAddModel.fromJson(json.decode(str));

String allAddModelToJson(AllAddModel data) => json.encode(data.toJson());

class AllAddModel {
  String stat;
  Ads ads;
  List<Tad> tad;
  String dataCat;
  String filteredTypeBrandModelCAll;

  AllAddModel({
    required this.stat,
    required this.ads,
    required this.tad,
    required this.dataCat,
    required this.filteredTypeBrandModelCAll,
  });

  factory AllAddModel.fromJson(Map<String, dynamic> json) => AllAddModel(
        stat: json["stat"],
        ads: Ads.fromJson(json["ads"]),
        tad: List<Tad>.from(json["tad"].map((x) => Tad.fromJson(x))),
        dataCat: json["data_cat"],
        filteredTypeBrandModelCAll: json["filtered-type-brand-model-cALL"],
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "ads": ads.toJson(),
        "tad": List<dynamic>.from(tad.map((x) => x.toJson())),
        "data_cat": dataCat,
        "filtered-type-brand-model-cALL": filteredTypeBrandModelCAll,
      };
}

class Ads {
  int currentPage;
  List<Tad> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Ads({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        currentPage: json["current_page"],
        data: List<Tad>.from(json["data"].map((x) => Tad.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Tad {
  String name;
  String adTitle;
  int adPrice;
  int id;
  String vtName;
  String adDistrict;
  String adCity;
  DateTime createdAt;
  int adNumber;
  int isTopId;

  Tad({
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

  factory Tad.fromJson(Map<String, dynamic> json) => Tad(
        name: json["name"] ??
            'https://img.freepik.com/free-psd/car-rental-automotive-web-banner-template_120329-4451.jpg?t=st=1736724363~exp=1736727963~hmac=54513102d7a407b52decaeffdc0d7b4b8fbb1529bf77d9e002ecc7ad54da9b70&w=996',
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

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
