import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/MyAddPackages.dart';

class MyAdsPackagesController extends ChangeNotifier {
  final ApiService _api = ApiService();
  final _dataController = StreamController<MyAddPackagesModel?>.broadcast();
  bool _isLoading = false;

  Stream<MyAddPackagesModel?> get dataStream => _dataController.stream;
  bool get isLoading => _isLoading;

  void dispose() {
    _dataController.close();
    super.dispose();
  }

  Future<void> fetchProducts(BuildContext context, int userId) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      final fetchedData = await _api.GetMyPackages(userId, context);

      if (fetchedData != null) {
        // If data is fetched successfully, add it to the stream
        _dataController.add(fetchedData);
        Logger().i('Fetched data: $fetchedData');
      } else {
        // Handle the case where data is null
        _dataController.add(null);
        Logger().w('No data fetched for userId: $userId');
      }
    } catch (e) {
      // Log and handle errors
      Logger().e('Error fetching packages: $e');
      _dataController.addError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
