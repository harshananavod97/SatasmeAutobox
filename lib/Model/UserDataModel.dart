import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String stat;
  User user;

  UserDataModel({
    required this.stat,
    required this.user,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        stat: json["stat"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "user": user.toJson(),
      };
}

class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt; // Keep dynamic since it may be null or another type
  String password;
  dynamic rememberToken; // Can be null
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  int isAdmin;
  int cusRoleId;
  dynamic facebookId; // Can be null
  dynamic googleId; // Can be null
  String? firstName; // Nullable
  String? lastName; // Nullable
  int? phone; // Nullable
  String? district; // Nullable
  String? city; // Nullable
  String? fbLink; // Nullable
  String? twitterLink; // Nullable
  String? linkedinLink; // Nullable
  String? youtubeLink; // Nullable
  String? profileImage; // Nullable
  int isFreePackageActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.password,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.isAdmin,
    required this.cusRoleId,
    required this.facebookId,
    required this.googleId,
    this.firstName,
    this.lastName,
    this.phone,
    this.district,
    this.city,
    this.fbLink,
    this.twitterLink,
    this.linkedinLink,
    this.youtubeLink,
    this.profileImage,
    required this.isFreePackageActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        isAdmin: json["isAdmin"],
        cusRoleId: json["cus_role_id"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        firstName: json["First_Name"],
        lastName: json["Last_Name"],
        phone: json["phone"],
        district: json["district"],
        city: json["city"],
        fbLink: json["Fb_link"],
        twitterLink: json["Twitter_link"],
        linkedinLink: json["Linkedin_link"],
        youtubeLink: json["Youtube_link"],
        profileImage: json["Profile_Image"],
        isFreePackageActive: json["is_free_package_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "isAdmin": isAdmin,
        "cus_role_id": cusRoleId,
        "facebook_id": facebookId,
        "google_id": googleId,
        "First_Name": firstName,
        "Last_Name": lastName,
        "phone": phone,
        "district": district,
        "city": city,
        "Fb_link": fbLink,
        "Twitter_link": twitterLink,
        "Linkedin_link": linkedinLink,
        "Youtube_link": youtubeLink,
        "Profile_Image": profileImage,
        "is_free_package_active": isFreePackageActive,
      };
}
