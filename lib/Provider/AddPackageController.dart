import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/Nomal_Ad_Package_Model.dart';
import 'package:newautobox/Model/Top-Ad_Package_Model.dart';

class Addpackagecontroller extends ChangeNotifier {
  bool _isLoading = false;
  NormaAdPackage? _addData;

  TopAdPackageModel? _adData;
  final ApiService _api = ApiService();

  bool get isLoading => _isLoading;
  NormaAdPackage? get NormalAdData => _addData;
  TopAdPackageModel? get TopAdData => _adData;

  Future<void> fetchNormalAds(BuildContext context) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      // Fetch user data from API
      final fetchedData = await _api.GetNormalAdPackage(context);

      if (fetchedData != null) {
        _addData = fetchedData; // Update the user data
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

  Future<void> fetchTopAds(BuildContext context) async {
    if (_isLoading) return; // Prevent duplicate fetch calls

    try {
      _isLoading = true;
      notifyListeners();

      // Fetch user data from API
      final fetchedData = await _api.GetTopAdPackage(context);

      if (fetchedData != null) {
        _adData = fetchedData; // Update the user data
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
}
