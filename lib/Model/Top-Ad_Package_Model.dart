

import 'dart:convert';

TopAdPackageModel topAdPackageModelFromJson(String str) => TopAdPackageModel.fromJson(json.decode(str));

String topAdPackageModelToJson(TopAdPackageModel data) => json.encode(data.toJson());

class TopAdPackageModel {
    String stat;
    List<Package> packages;

    TopAdPackageModel({
        required this.stat,
        required this.packages,
    });

    factory TopAdPackageModel.fromJson(Map<String, dynamic> json) => TopAdPackageModel(
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
    int count;
    DateTime createdAt;
    DateTime updatedAt;
    int status;
    int packagePrice;

    Package({
        required this.id,
        required this.packageName,
        required this.count,
        required this.createdAt,
        required this.updatedAt,
        required this.status,
        required this.packagePrice,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        packageName: json["package_name"],
        count: json["count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        packagePrice: json["package_price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "count": count,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "package_price": packagePrice,
    };
}
