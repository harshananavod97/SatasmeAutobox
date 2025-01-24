
import 'dart:convert';

VehicleTypes vehicleTypesFromJson(String str) => VehicleTypes.fromJson(json.decode(str));

String vehicleTypesToJson(VehicleTypes data) => json.encode(data.toJson());

class VehicleTypes {
    String stat;
    List<Datum> data;

    VehicleTypes({
        required this.stat,
        required this.data,
    });

    factory VehicleTypes.fromJson(Map<String, dynamic> json) => VehicleTypes(
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
    String vtName;

    Datum({
        required this.id,
        required this.vtName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        vtName: json["vt_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "vt_name": vtName,
    };
}
