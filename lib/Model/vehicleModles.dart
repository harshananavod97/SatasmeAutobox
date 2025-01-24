// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) =>
    VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  String stat;
  List<Model> model;

  VehicleModel({
    required this.stat,
    required this.model,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        stat: json["stat"],
        model: List<Model>.from(json["model"].map((x) => Model.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "model": List<dynamic>.from(model.map((x) => x.toJson())),
      };
}

class Model {
  int id;
  String modelName;
  int status;
  int brandId;
  DateTime createdAt;
  DateTime updatedAt;

  Model({
    required this.id,
    required this.modelName,
    required this.status,
    required this.brandId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        modelName: json["model_name"],
        status: json["status"],
        brandId: json["brand_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_name": modelName,
        "status": status,
        "brand_id": brandId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
