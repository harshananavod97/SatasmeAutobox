// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) =>
    BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
  String stat;
  List<Brand> brands;

  BrandModel({
    required this.stat,
    required this.brands,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        stat: json["stat"],
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
      };
}

class Brand {
  int brandId;
  String brandName;
  String models;

  Brand({
    required this.brandId,
    required this.brandName,
    required this.models,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        brandId: json["brand_id"],
        brandName: json["brand_name"],
        models: json["models"],
      );

  Map<String, dynamic> toJson() => {
        "brand_id": brandId,
        "brand_name": brandName,
        "models": models,
      };
}
