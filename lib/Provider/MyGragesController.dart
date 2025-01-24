import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';

import '../Model/MygargesModel.dart';

class MyGragesDataController extends ChangeNotifier {
  final ApiService _api = ApiService();
  final _dataController = StreamController<MyGrages?>.broadcast();
  bool _isLoading = false;

  Stream<MyGrages?> get dataStream => _dataController.stream;
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

      final fetchedData = await _api.GetUserGrage(userId, context);

      if (fetchedData != null) {
        _dataController.add(fetchedData);
        Logger().i('Garage data fetched successfully');
      } else {
        _dataController.add(null);
        Logger().w('No garage data found');
      }
    } catch (e) {
      Logger().e('Error fetching garage data: $e');
      _dataController.addError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _city = '';
  String _district = '';
  String get City => _city;
  String get District => _district;

  void SetCity(String city) {
    _city = city;
    notifyListeners();
  }

  void SetDistrict(String district) {
    _district = district;
    notifyListeners();
  }
}
