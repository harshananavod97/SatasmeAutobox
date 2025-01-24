// To parse this JSON data, do
//
//     final normaAdPackage = normaAdPackageFromJson(jsonString);

import 'dart:convert';

NormaAdPackage normaAdPackageFromJson(String str) => NormaAdPackage.fromJson(json.decode(str));

String normaAdPackageToJson(NormaAdPackage data) => json.encode(data.toJson());

class NormaAdPackage {
    String stat;
    List<Package> packages;

    NormaAdPackage({
        required this.stat,
        required this.packages,
    });

    factory NormaAdPackage.fromJson(Map<String, dynamic> json) => NormaAdPackage(
        stat: json["stat"],
        packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "stat": stat,
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    };
}

class Package {
    int id;
    String packageName;
    int packageAdCount;
    int packageDuration;
    int packagePrice;
    int status;
    int categoryId;
    DateTime createdAt;
    DateTime updatedAt;
    int topupCount;
    int imageCount;

    Package({
        required this.id,
        required this.packageName,
        required this.packageAdCount,
        required this.packageDuration,
        required this.packagePrice,
        required this.status,
        required this.categoryId,
        required this.createdAt,
        required this.updatedAt,
        required this.topupCount,
        required this.imageCount,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        packageName: json["package_name"],
        packageAdCount: json["package_ad_count"],
        packageDuration: json["package_duration"],
        packagePrice: json["package_price"],
        status: json["status"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        topupCount: json["topup_count"],
        imageCount: json["image_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "package_ad_count": packageAdCount,
        "package_duration": packageDuration,
        "package_price": packagePrice,
        "status": status,
        "category_id": categoryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "topup_count": topupCount,
        "image_count": imageCount,
    };
}
