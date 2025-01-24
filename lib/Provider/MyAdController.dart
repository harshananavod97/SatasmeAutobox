import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/MyAdModel.dart';

class MyAdController extends ChangeNotifier {
  final ApiService _api = ApiService();
  final _dataController = StreamController<MyAdModel?>.broadcast();
  bool _isLoading = false;

  Stream<MyAdModel?> get dataStream => _dataController.stream;
  bool get isLoading => _isLoading;

  void dispose() {
    _dataController.close();
    super.dispose();
  }
  //InqueryModel

  Future<void> fetchProducts(BuildContext context, int userId) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      final fetchedData = await _api.GetUserAdd(userId, context);

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

  // State management properties
  String _vehicle = '';
  String _brand = '';
  String _model = '';
  String get VehicleType => _vehicle;
  String get BrandType => _brand;
  String get ModelType => _model;

  int _vehicleID = 5;
  int _brandID = 1;
  int _modelID = 125;
  int get Vehicleid => _vehicleID;
  int get BrandID => _brandID;
  int get ModelID => _modelID;

  void SetVehicleName(String city) {
    _vehicle = city;
    notifyListeners();
  }

  void SetVehicleBrandName(String city) {
    _brand = city;
    notifyListeners();
  }

  void SetVehicleMODELName(String city) {
    _model = city;
    notifyListeners();
  }

  void SetVehicleId(int id) {
    _vehicleID = id;
    notifyListeners();
  }

  void SetBrandID(int id) {
    _brandID = id;
    notifyListeners();
  }

  void SetModelID(int id) {
    _modelID = id;
    notifyListeners();
  }
}
