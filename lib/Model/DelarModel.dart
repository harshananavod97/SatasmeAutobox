// To parse this JSON data, do
//
//     final delarDataModel = delarDataModelFromJson(jsonString);

import 'dart:convert';

DelarDataModel delarDataModelFromJson(String str) =>
    DelarDataModel.fromJson(json.decode(str));

String delarDataModelToJson(DelarDataModel data) => json.encode(data.toJson());

class DelarDataModel {
  String stat;
  int userId;
  String companylogo;
  String companyName;
  String address;
  String googleLocation;

  DelarDataModel({
    required this.stat,
    required this.userId,
    required this.companylogo,
    required this.companyName,
    required this.address,
    required this.googleLocation,
  });

  factory DelarDataModel.fromJson(Map<String, dynamic> json) => DelarDataModel(
        stat: json["stat"],
        userId: json["user_id"] ?? 2,
        companylogo: json["companylogo"] ?? '',
        companyName: json["Company_Name"] ?? '',
        address: json["address"] ?? '',
        googleLocation: json["google_location"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "user_id": userId,
        "companylogo": companylogo,
        "Company_Name": companyName,
        "address": address,
        "google_location": googleLocation,
      };
}
