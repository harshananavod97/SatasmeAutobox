// To parse this JSON data, do
//
//     final getGrageData = getGrageDataFromJson(jsonString);

import 'dart:convert';

GetGrageData getGrageDataFromJson(String str) =>
    GetGrageData.fromJson(json.decode(str));

String getGrageDataToJson(GetGrageData data) => json.encode(data.toJson());

class GetGrageData {
  final String stat;
  final Garages? garages; // Made nullable to handle cases where it's absent
  final String? check; // Made nullable

  GetGrageData({
    required this.stat,
    this.garages,
    this.check,
  });

  factory GetGrageData.fromJson(Map<String, dynamic> json) => GetGrageData(
        stat: json["stat"] ?? '',
        garages:
            json["garages"] != null ? Garages.fromJson(json["garages"]) : null,
        check: json["check"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "garages": garages?.toJson(), // Safely handle nullable
        "check": check,
      };
}

class Garages {
  final int? currentPage; // Made nullable
  final List<Datum> data;
  final String? firstPageUrl; // Made nullable
  final int? from; // Made nullable
  final int? lastPage; // Made nullable
  final String? lastPageUrl; // Made nullable
  final List<Link> links;
  final String? nextPageUrl; // Made nullable
  final String? path; // Made nullable
  final int? perPage; // Made nullable
  final String? prevPageUrl; // Made nullable
  final int? to; // Made nullable
  final int? total; // Made nullable

  Garages({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Garages.fromJson(Map<String, dynamic> json) => Garages(
        currentPage: json["current_page"] ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"] ?? '',
        from: json["from"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        lastPageUrl: json["last_page_url"] ?? '',
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"] ?? '',
        path: json["path"] ?? '',
        perPage: json["per_page"] ?? 0,
        prevPageUrl: json["prev_page_url"] ?? '',
        to: json["to"] ?? 0,
        total: json["total"] ?? 0,
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

class Datum {
  final String name;
  final String address;
  final String city;
  final String image;
  final String number;
  final int id;

  Datum({
    required this.name,
    required this.address,
    required this.city,
    required this.image,
    required this.number,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"] ?? '',
        address: json["address"] ?? '',
        city: json["city"] ?? '',
        image: json["image"] ?? '',
        number: json["number"] ?? '',
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "city": city,
        "image": image,
        "number": number,
        "id": id,
      };
}

class Link {
  final String? url; // Made nullable
  final String label;
  final bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"] ?? '',
        active: json["active"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
