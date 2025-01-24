// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  String stat;
  List<Datum> data;

  CityModel({
    required this.stat,
    required this.data,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        stat: json["stat"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String nameEn;

  Datum({
    required this.id,
    required this.nameEn,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        nameEn: json["name_en"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
      };
}
