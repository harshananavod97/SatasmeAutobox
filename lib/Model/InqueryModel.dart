// To parse this JSON data, do
//
//     final inqueryModel = inqueryModelFromJson(jsonString);

import 'dart:convert';

InqueryModel inqueryModelFromJson(String str) =>
    InqueryModel.fromJson(json.decode(str));

String inqueryModelToJson(InqueryModel data) => json.encode(data.toJson());

class InqueryModel {
  String stat;
  Inq inq;
  String check;

  InqueryModel({
    required this.stat,
    required this.inq,
    required this.check,
  });

  factory InqueryModel.fromJson(Map<String, dynamic> json) => InqueryModel(
        stat: json["stat"],
        inq: Inq.fromJson(json["inq"]),
        check: json["check"],
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "inq": inq.toJson(),
        "check": check,
      };
}

class Inq {
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

  Inq({
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

  factory Inq.fromJson(Map<String, dynamic> json) => Inq(
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
  String title;
  String phone;
  String additionalInformation;
  int userId;
  DateTime createdAt;
  int id;
  String image;

  Datum({
    required this.title,
    required this.phone,
    required this.additionalInformation,
    required this.userId,
    required this.createdAt,
    required this.id,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        phone: json["phone"],
        additionalInformation: json["additional_information"],
        userId: json["userID"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "phone": phone,
        "additional_information": additionalInformation,
        "userID": userId,
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "image": image,
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