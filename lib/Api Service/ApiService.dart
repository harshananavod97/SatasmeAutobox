import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Model/AllAdsModel.dart';
import 'package:newautobox/Model/CityModel.dart';
import 'package:newautobox/Model/DelarModel.dart';
import 'package:newautobox/Model/DistrictModel.dart';
import 'package:newautobox/Model/GetGrageData.dart';
import 'package:newautobox/Model/InqueryModel.dart';
import 'package:newautobox/Model/LatestAdsModel.dart';
import 'package:newautobox/Model/MyAdModel.dart';
import 'package:newautobox/Model/MyAddPackages.dart';
import 'package:newautobox/Model/MygargesModel.dart';
import 'package:newautobox/Model/Nomal_Ad_Package_Model.dart';
import 'package:newautobox/Model/Top-Ad_Package_Model.dart';
import 'package:newautobox/Model/UserDataModel.dart';
import 'package:newautobox/Model/VehicleBrandModel.dart';
import 'package:newautobox/Model/VehicleTypes.dart';
import 'package:newautobox/Model/vehicleModles.dart';
import 'package:newautobox/Screens/SignInScreen.dart';
import 'package:newautobox/Screens/dashboard_screen.dart';
import 'package:newautobox/Utils/Const/Constant.dart';
import 'package:newautobox/Utils/Scaffholdmessanger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<bool> UserRegister(
    String email,
    String username,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.post(
        '$BaseUrl/mobile/signup',
        data: {"email": email, "username": username, "password": password},
      );
      Logger().i(response.statusMessage);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(
                Email: email,
                Password: password,
              ),
            ));
        return true;
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      Logger().i(e.message);
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<bool> UserLogin(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.post(
        '$BaseUrl/mobile/login',
        data: {"email": email, "password": password},
      );
      Logger().i(response.statusMessage);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('isUserEmail', email);

        // final userController =
        //     Provider.of<Userdatacontroller>(context, listen: false);

        // // Fetch user data
        // await userController.fetchProducts(
        //   prefs.getString(email).toString(),
        //   context,
        // );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(
                email: email,
              ),
            ));
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Logger().i(e.message);
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<UserDataModel> GetUserData(
    String UserEmail,
    BuildContext context,
  ) async {
    try {
      final response = await _dio
          .post('$BaseUrl/mobile/getUserData', data: {"email": UserEmail});

      Logger().i(response.data);

      if (response.statusCode == 200) {
        return UserDataModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<bool> UserProfileUpdate(
    String email,
    String firstName,
    String Lastname,
    String phoneNumber,
    String district,
    String city,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.post(
        '$BaseUrl/mobile/userProfileDataUpdate',
        data: {
          "email": email,
          "firstName": firstName,
          "lastName": Lastname,
          "phoneNo": phoneNumber,
          "district": district,
          "city": city
        },
      );
      Logger().i(response.statusMessage);
      if (response.statusCode == 200) {
        showSnackBar(
          'Profile  Updated', // Message to display
          context, // Current BuildContext
          showAction: false, // Optional: show action button
          onPressedAction: () {
            // Action button callback
            showSnackBar('Sucess...', context);
          },
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('isUserEmail', email);

        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Logger().i(e.message);
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  //Add Packages

  Future<NormaAdPackage> GetNormalAdPackage(BuildContext context) async {
    try {
      final response = await _dio.get('$BaseUrl/mobile/getAllAdPackages');

      Logger().i(response.data);

      if (response.statusCode == 200) {
        return NormaAdPackage.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<TopAdPackageModel> GetTopAdPackage(BuildContext context) async {
    try {
      final response = await _dio.get('$BaseUrl/mobile/getAllTopAdPackages');

      Logger().i(response.data);

      if (response.statusCode == 200) {
        return TopAdPackageModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<VehicleTypes> GetVehicleTypes(BuildContext context) async {
    try {
      final response = await _dio.post('$BaseUrl/mobile/getVehicleTypes');

      Logger().i(response.data);

      if (response.statusCode == 200) {
        return VehicleTypes.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<DistrictModel> GetDistrict(BuildContext context) async {
    try {
      final response = await _dio.post('$BaseUrl/mobile/getDistricts');

      Logger().i(response.data);

      if (response.statusCode == 200) {
        return DistrictModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<CityModel> GetCity(BuildContext context, int id) async {
    try {
      final response = await _dio
          .post('$BaseUrl/mobile/getCities', data: {"district_id": id});

      Logger().e(response.data);

      if (response.statusCode == 200) {
        return CityModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<VehicleModel> GetVehicleModel(
      BuildContext context, int brandid) async {
    try {
      final response = await _dio
          .post('$BaseUrl/mobile/getBrandvtype', data: {"brandId": brandid});

      Logger().e(response.data);

      if (response.statusCode == 200) {
        return VehicleModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<BrandModel> GetBrandModel(BuildContext context, int vehicleid) async {
    try {
      final response = await _dio
          .post('$BaseUrl/mobile/getBrandModel', data: {"vtId": vehicleid});

      Logger().e(response.data);

      if (response.statusCode == 200) {
        return BrandModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<VehicleModel> getvehiclemodel(
      BuildContext context, int brandid) async {
    try {
      final response = await _dio
          .post('$BaseUrl/mobile/getBrandModel', data: {"brandId": brandid});

      Logger().e(response.data);

      if (response.statusCode == 200) {
        return VehicleModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<GetGrageData> GetGrageDat(BuildContext context, String city) async {
    try {
      final response = await _dio.get(
        '$BaseUrl/mobile/getFilteredPaginatedGarages?location=$city',
      );

      Logger().i(response.data);

      if (response.statusCode == 200) {
        return GetGrageData.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<bool> UserProfileImageUpload(
    String uid,
    File? file, // This will hold the file data (image file)
    BuildContext context,
  ) async {
    try {
      // Prepare form data with the image file and user ID
      FormData formData = FormData.fromMap({
        "uid": uid, // Correct key
        "profile_img": await MultipartFile.fromFile(file!.path),
      });

      // Sending POST request
      final response = await Dio().post(
        '$BaseUrl/mobile/updateProfileImage', // Replace with actual URL
        data: formData,
      );

      Logger().e(response.data);

      // Log the response status
      print(response.statusMessage);

      // Check if the response status code is 200 (Success)
      if (response.statusCode == 200) {
        showSnackBar(
          'Profile Image Updated', // Message to display
          context, // Current BuildContext
          showAction: false, // Optional: show action button
          onPressedAction: () {
            //  Action button callback
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      // Handle Dio exceptions and show appropriate error messages
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      // Show the error message in a SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      // Optionally rethrow the exception or handle further
      throw Exception(errorMessage);
    }
  }

  Future<bool> DelarProfileImageUpload(
    int uid,
    File? file, // This will hold the file data (image file)
    BuildContext context,
  ) async {
    try {
      // Prepare form data with the image file and user ID
      FormData formData = FormData.fromMap({
        "uid": uid, // Correct key
        "dealer_logo": await MultipartFile.fromFile(file!.path),
      });

      // Sending POST request
      final response = await Dio().post(
        '$BaseUrl/mobile/updateDealerLogoImage', // Replace with actual URL
        data: formData,
      );

      Logger().e(response.data);

      // Log the response status
      print(response.statusMessage);

      // Check if the response status code is 200 (Success)
      if (response.statusCode == 200) {
        showSnackBar(
          'Profile Image Updated', // Message to display
          context, // Current BuildContext
          showAction: false, // Optional: show action button
          onPressedAction: () {
            // Action button callback
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      // Handle Dio exceptions and show appropriate error messages
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      // Show the error message in a SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      // Optionally rethrow the exception or handle further
      throw Exception(errorMessage);
    }
  }

/////////////////////////////////////////////Dealar End points//////
  Future<bool> CreateDelar(
    String uid,
    String companyname,
    String address,
    String googlelocation,
    File? file, // This will hold the file data (image file)
    BuildContext context,
  ) async {
    try {
      // Prepare form data with the image file and user ID
      FormData formData = FormData.fromMap({
        "uid": uid,
        "company_name": companyname,
        "address": address,
        "google_location": googlelocation,
        "company_logo": await MultipartFile.fromFile(file!.path),
      });

      // Sending POST request
      final response = await Dio().post(
        '$BaseUrl/mobile/becomeADealer', // Replace with actual URL
        data: formData,
      );

      Logger().e(response.data);

      // Log the response status
      print(response.statusMessage);

      // Check if the response status code is 200 (Success)
      if (response.statusCode == 200) {
        showSnackBar(
          'Delar Profile Created', // Message to display
          context, // Current BuildContext
          showAction: false, // Optional: show action button
          onPressedAction: () {
            // Action button callback
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      // Handle Dio exceptions and show appropriate error messages
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      // Show the error message in a SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      // Optionally rethrow the exception or handle further
      throw Exception(errorMessage);
    }
  }

  Future<bool> UpdateDelar(
    String uid,
    String companyname,
    String address,
    String googlelocation,
    BuildContext context,
  ) async {
    try {
      // Prepare form data with the image file and user ID
      FormData formData = FormData.fromMap({
        "uid": uid,
        "company_name": companyname,
        "address": address,
        "google_location": googlelocation,
      });

      // Sending POST request
      final response = await Dio().post(
        '$BaseUrl/mobile/updateDealer', // Replace with actual URL
        data: formData,
      );

      Logger().e(response.data);

      // Log the response status
      print(response.statusMessage);

      // Check if the response status code is 200 (Success)
      if (response.statusCode == 200) {
        showSnackBar(
          'Delar Profile Updated', // Message to display
          context, // Current BuildContext
          showAction: false, // Optional: show action button
          onPressedAction: () {
            // Action button callback
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      // Handle Dio exceptions and show appropriate error messages
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      // Show the error message in a SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      // Optionally rethrow the exception or handle further
      throw Exception(errorMessage);
    }
  }

  Future<DelarDataModel> GetDelarData(
    int UserId,
    BuildContext context,
  ) async {
    try {
      final response = await _dio
          .get('$BaseUrl/mobile/getDealerData', data: {"user_id": UserId});

      Logger().i(response.data);

      if (response.statusCode == 200) {
        return DelarDataModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  //Searach  ADS Fetch EndPoints

  Future<AllAddModel> GetAds(
    int VehicleType,
    int brandId,
    int modelId,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.get(
        '$BaseUrl/mobile/getFilteredPaginatedAds?vType=$VehicleType&brandId=$brandId&modelId=$modelId&location=Any Location',
      );

      Logger().i(VehicleType + brandId + modelId);

      if (response.statusCode == 200) {
        return AllAddModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<AllAddModel> GeSearchtAds(
    String itemName,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.get(
        '$BaseUrl/mobile/getFilteredPaginatedAds?itemName=$itemName&location=Any Location',
      );

      if (response.statusCode == 200) {
        return AllAddModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  ///////////////////////////////////////////Grage Management ///////////////////////////////////////

  Future<bool> CreateGrage(
    int user_id,
    String garagename,
    String city,
    String telephonenumber,
    String googleLocation,
    String description,
    String address,
    File? file,
    BuildContext context,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "user_id": user_id,
        "garage_name": garagename,
        "city": city,
        "tele": telephonenumber,
        "google_location": googleLocation,
        "desc": description,
        "address": address,
        "garage_logo": await MultipartFile.fromFile(file!.path),
      });

      final response = await Dio().post(
        '$BaseUrl/mobile/createGarage',
        data: formData,
      );

      Logger().e(response.data);

      print(response.statusMessage);

      if (response.statusCode == 200) {
        showSnackBar(
          'Grage Created',
          context,
          showAction: false,
          onPressedAction: () {
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<MyGrages> GetUserGrage(
    int userId,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.get(
        '$BaseUrl/mobile/getUserGarages?user_id=$userId',
      );

      if (response.statusCode == 200) {
        return MyGrages.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  //Add Management

  Future<bool> CreateAdd(
    String adtitlle,
    String adDistrict,
    String city,
    String description,
    int price,
    int vtid,
    int btid,
    int mtid,
    String adcondition,
    int uid,
    int istop,
    int isnogetiable,
    File? file,
    BuildContext context,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "ad_title": adtitlle,
        "ad_district": adDistrict,
        "ad_city": city,
        "ad_description": description,
        "ad_price": price,
        "vehicle_types_id": vtid,
        "brands_id": btid,
        "models_id": mtid,
        "ads_condition": adcondition,
        "ads_customers_id": uid,
        "is_top_id": istop,
        "negotiable": isnogetiable,
        "img[]": await MultipartFile.fromFile(file!.path),
      });

      final response = await Dio().post(
        '$BaseUrl/mobile/createAd',
        data: formData,
      );

      Logger().e(response.data);

      print(response.statusMessage);

      if (response.statusCode == 200) {
        showSnackBar(
          'Ad Created',
          context,
          showAction: false,
          onPressedAction: () {
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<bool> UpdateAdd(
    int adid,
    String adtitlle,
    String description,
    String adcondition,
    String adprice,
    int isnogetiable,
    // File? file,
    BuildContext context,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "ad_id": adid,
        "ad_title": adtitlle,
        "ad_description": description,
        "ad_price": adprice,
        "ads_condition": adcondition,
        "negotiable": isnogetiable,
        // "img": await MultipartFile.fromFile(file!.path),
      });

      final response = await Dio().post(
        '$BaseUrl/mobile/updateAd',
        data: formData,
      );

      Logger().e(response.data);

      print(response.statusMessage);

      if (response.statusCode == 200) {
        showSnackBar(
          'Ad Updated',
          context,
          showAction: false,
          onPressedAction: () {
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<bool> disableAd(
    int adid,
    BuildContext context,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "ad_id": adid,
      });

      final response = await Dio().post(
        '$BaseUrl/mobile/disableAd',
        data: formData,
      );

      Logger().e(response.data);

      print(response.statusMessage);

      if (response.statusCode == 200) {
        showSnackBar(
          'Ad disable Sucess',
          context,
          showAction: false,
          onPressedAction: () {
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<MyAdModel> GetUserAdd(
    int userId,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.post(
        '$BaseUrl/mobile/getAdData?uid=$userId',
      );

      if (response.statusCode == 200) {
        return MyAdModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<LatestAdsModel> GetLatestAdd(
    BuildContext context,
  ) async {
    try {
      final response = await _dio.post(
        '$BaseUrl/mobile/getRecentAds',
      );

      if (response.statusCode == 200) {
        return LatestAdsModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  //inquery   Management

  Future<bool> CreateInquery(
    String title,
    String phonenumber,
    int uid,
    String aditionalinformation,
    File? file,
    BuildContext context,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "title": title,
        "phone": phonenumber,
        "userID": uid,
        "additional_information": aditionalinformation,
        "image": await MultipartFile.fromFile(file!.path),
      });

      final response = await Dio().post(
        '$BaseUrl/mobile/PlaceAnInquiry',
        data: formData,
      );

      Logger().e(response.data);

      print(response.statusMessage);

      if (response.statusCode == 200) {
        showSnackBar(
          'Inquery Created',
          context,
          showAction: false,
          onPressedAction: () {
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<InqueryModel> GetUserInquery(
    int userId,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.get(
        '$BaseUrl/mobile/getMyInquiry?uid=$userId',
      );

      if (response.statusCode == 200) {
        return InqueryModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<bool> deleteInquery(int inqueryid, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap({
        "id": inqueryid,
      });

      final response = await Dio().post(
        '$BaseUrl/mobile/deleteInq',
        data: formData,
      );

      Logger().e(response.data);

      print(response.statusMessage);

      if (response.statusCode == 200) {
        showSnackBar(
          'Inquery Deleted',
          context,
          showAction: false,
          onPressedAction: () {
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  //__________________PackagesEndPoints___________

  Future<bool> BuyNormalAddPackage(
    int uid,
    int pid,
    BuildContext context,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "uid": uid,
        "pid": pid,
      });

      final response = await Dio().post(
        '$BaseUrl/mobile/buyPaidAdPackage',
        data: formData,
      );

      Logger().e(response.data);

      print(response.statusMessage);

      if (response.statusCode == 200) {
        showSnackBar(
          'Grage Created',
          context,
          showAction: false,
          onPressedAction: () {
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<bool> BuyTopAddPackage(
    int uid,
    int pid,
    BuildContext context,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "uid": uid,
        "pid": pid,
      });

      final response = await Dio().post(
        '$BaseUrl/mobile/buyTopPaidAdPackage',
        data: formData,
      );

      Logger().e(response.data);

      print(response.statusMessage);

      if (response.statusCode == 200) {
        showSnackBar(
          'Grage Created',
          context,
          showAction: false,
          onPressedAction: () {
            showSnackBar('Sucess...', context);
          },
          duration: Duration(seconds: 3), // Optional: custom duration
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }

  Future<MyAddPackagesModel> GetMyPackages(
    int uid,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.get(
        '$BaseUrl/mobile/getMyAdPackage?uid=$uid',
      );

      if (response.statusCode == 200) {
        return MyAddPackagesModel.fromJson(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      String errorMessage = switch (e.response?.statusCode) {
        400 => 'Bad Request.',
        401 => 'Unauthorized.',
        503 => 'Service Unavailable.',
        _ => 'Something went wrong',
      };

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      throw Exception(errorMessage);
    }
  }
}
