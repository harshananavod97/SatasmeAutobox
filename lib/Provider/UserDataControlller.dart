import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/UserDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userdatacontroller extends ChangeNotifier {
  bool _isLoading = false;
  UserDataModel?
      _userData; // Use a single object instead of a list if fetching a single user
  final ApiService _api = ApiService();

  bool get isLoading => _isLoading;
  UserDataModel? get userData => _userData; // Getter for userData
  Future<void> fetchProducts(String email, BuildContext context) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      // Add debug logging
      Logger().d('Fetching data for email: $email');

      final response = await _api.GetUserData(email, context);

      // Debug log the response
      Logger().d('API Response: $response (Type: ${response?.runtimeType})');

      if (response == null) {
        Logger().w('API response is null');
        return;
      }

      _userData = response;

      Logger().i('User data fetched successfully');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('isUserId', _userData!.user.id);
    } catch (e) {
      Logger().e('Error fetching user data: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _city = '';
  String _district = '';
  String get City => _city;
  String get District => _district;

  int _cityID = 25;
  int _districtID = 1;
  int get Cityid => _cityID;
  int get DistrictID => _districtID;

  void SetCity(String city) {
    _city = city;
    notifyListeners();
  }

  void SetDistrict(String district) {
    _district = district;
    notifyListeners();
  }

  void SetCityId(int city) {
    _cityID = city;
    notifyListeners();
  }

  void SetDistrictID(int district) {
    _districtID = district;
    notifyListeners();
  }
}
