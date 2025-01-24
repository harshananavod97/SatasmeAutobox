// To parse this JSON data, do
//
//     final myGrages = myGragesFromJson(jsonString);

import 'dart:convert';

MyGrages myGragesFromJson(String str) => MyGrages.fromJson(json.decode(str));

String myGragesToJson(MyGrages data) => json.encode(data.toJson());

class MyGrages {
  String stat;
  Garages garages;
  String check;

  MyGrages({
    required this.stat,
    required this.garages,
    required this.check,
  });

  factory MyGrages.fromJson(Map<String, dynamic> json) => MyGrages(
        stat: json["stat"],
        garages: Garages.fromJson(json["garages"]),
        check: json["check"],
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "garages": garages.toJson(),
        "check": check,
      };
}

class Garages {
  int currentPage;
  List<Datum> data;
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

  Garages({
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

  factory Garages.fromJson(Map<String, dynamic> json) => Garages(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  String name;
  String address;
  String city;
  String image;
  String number;
  int id;

  Datum({
    required this.name,
    required this.address,
    required this.city,
    required this.image,
    required this.number,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        image: json["image"],
        number: json["number"],
        id: json["id"],
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
