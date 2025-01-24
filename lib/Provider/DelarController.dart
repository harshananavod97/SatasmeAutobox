import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/DelarModel.dart';

class DelarController extends ChangeNotifier {
  bool _isLoading = false;
  DelarDataModel?
      _delarData; // Use a single object instead of a list if fetching a single user
  final ApiService _api = ApiService();

  bool get isLoading => _isLoading;
  DelarDataModel? get delarData => _delarData; // Getter for delaData
  Future<void> fetchDelarData(int userId, BuildContext context) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      // Add debug logging
      Logger().d('Fetching data for email: $userId');

      final response = await _api.GetDelarData(userId, context);

      // Debug log the response
      Logger().d('API Response: $response (Type: ${response?.runtimeType})');

      if (response == null) {
        Logger().w('API response is null');
        return;
      }

      _delarData = response;
      Logger().i('User data fetched successfully');
    } catch (e) {
      Logger().e('Error fetching user data: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
