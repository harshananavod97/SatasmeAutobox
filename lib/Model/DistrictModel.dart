// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
    String stat;
    List<Datum> data;

    DistrictModel({
        required this.stat,
        required this.data,
    });

    factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
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
        id: json["id"],
        nameEn: json["name_en"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
    };
}
