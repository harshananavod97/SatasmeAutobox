import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/CityModel.dart';
import 'package:newautobox/Model/DistrictModel.dart';

class Locationcontroller extends ChangeNotifier {
  bool _isLoading = false;
  DistrictModel?
      _getDistrict; // Use a single object instead of a list if fetching a single user
  final ApiService _api = ApiService();

  CityModel?
      _getCity; // Use a single object instead of a list if fetching a single user

  CityModel? get cityData => _getCity;
  bool get isLoading => _isLoading;
  DistrictModel? get districtData => _getDistrict; // Getter for userData

  Future<void> fetchProducts(BuildContext context) async {
    if (_isLoading) return; // Prevent duplicate fetch calls

    try {
      _isLoading = true;
      notifyListeners();

      // Fetch user data from API
      final fetchedData = await _api.GetDistrict(context);

      if (fetchedData != null) {
        _getDistrict = fetchedData; // Update the user data
        Logger().i('User data fetched successfully');
      } else {
        Logger().w('No user data found');
      }
    } catch (e) {
      Logger().e('Error fetching user data: $e');
      rethrow; // Pass the error for further handling if needed
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners();
    }
  }

  Future<void> fetchCity(BuildContext context, int id) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Fetch user data from API
      final fetchedData = await _api.GetCity(context, id);

      if (fetchedData != null) {
        _getCity = fetchedData; // Update the user data
        Logger().i('User data fetched successfully');
      } else {
        Logger().w('No user data found');
      }
    } catch (e) {
      Logger().e('Error fetching user data: $e');
      rethrow; // Pass the error for further handling if needed
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners();
    }
  }

  void clearCityData() {
    _getCity = null;
    notifyListeners();
  }
}
