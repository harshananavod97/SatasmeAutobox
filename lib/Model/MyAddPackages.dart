import 'dart:convert';

MyAddPackagesModel myAddPackagesModelFromJson(String str) =>
    MyAddPackagesModel.fromJson(json.decode(str));

String myAddPackagesModelToJson(MyAddPackagesModel data) =>
    json.encode(data.toJson());

class MyAddPackagesModel {
  String stat;
  Mypack mypack;

  MyAddPackagesModel({
    required this.stat,
    required this.mypack,
  });

  factory MyAddPackagesModel.fromJson(Map<String, dynamic> json) =>
      MyAddPackagesModel(
        stat: json["stat"],
        mypack: Mypack.fromJson(json["mypack"]),
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "mypack": mypack.toJson(),
      };
}

class Mypack {
  String packageName;
  int availableAdCount;
  int availableTopCount;
  DateTime packageStartDate;
  DateTime packageExpireDate;
  int imageCount;

  Mypack({
    required this.packageName,
    required this.availableAdCount,
    required this.availableTopCount,
    required this.packageStartDate,
    required this.packageExpireDate,
    required this.imageCount,
  });

  factory Mypack.fromJson(Map<String, dynamic> json) => Mypack(
        packageName: json["package_name"] ?? "",
        availableAdCount: json["available_ad_count"] ?? 0,
        availableTopCount: json["available_top_count"] ?? 0,
        packageStartDate: DateTime.parse(json["package_start_date"] ?? ''),
        packageExpireDate: DateTime.parse(json["package_expire_date"] ?? ''),
        imageCount: json["image_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "package_name": packageName,
        "available_ad_count": availableAdCount,
        "available_top_count": availableTopCount,
        "package_start_date": packageStartDate.toIso8601String(),
        "package_expire_date": packageExpireDate.toIso8601String(),
        "image_count": imageCount,
      };
}
