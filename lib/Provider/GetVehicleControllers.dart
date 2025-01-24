import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/VehicleBrandModel.dart';
import 'package:newautobox/Model/VehicleTypes.dart';
import 'package:newautobox/Model/vehicleModles.dart';

class Getvehiclecontrollers extends ChangeNotifier {
  final ApiService _api = ApiService();

  // Data Models
  BrandModel? _getbrandmodel;
  VehicleModel? _getvehiclemodel;
  VehicleTypes? _getVehicleType;

  // Broadcast StreamControllers to allow multiple listeners
  final StreamController<VehicleTypes?> _vehicleTypeController =
      StreamController<VehicleTypes?>.broadcast();
  final StreamController<BrandModel?> _brandModelController =
      StreamController<BrandModel?>.broadcast();
  final StreamController<VehicleModel?> _vehicleModelController =
      StreamController<VehicleModel?>.broadcast();

  // Getters for Streams
  Stream<VehicleTypes?> get vehicleTypeStream => _vehicleTypeController.stream;
  Stream<BrandModel?> get brandModelStream => _brandModelController.stream;
  Stream<VehicleModel?> get vehicleModelStream =>
      _vehicleModelController.stream;

  // Rest of your existing methods remain the same
  Future<void> fetchVechicleType(BuildContext context) async {
    try {
      final fetchedData = await _api.GetVehicleTypes(context);
      if (fetchedData != null) {
        _getVehicleType = fetchedData;
        _vehicleTypeController.add(fetchedData);
        Logger().i('Vehicle types fetched successfully');
      } else {
        _vehicleTypeController.add(null);
        Logger().w('No vehicle types found');
      }
    } catch (e) {
      _vehicleTypeController.addError(e);
      Logger().e('Error fetching vehicle types: $e');
    }
  }

  Future<void> fetchBrandType(BuildContext context, int vehicleid) async {
    try {
      final fetchedData = await _api.GetBrandModel(context, vehicleid);
      if (fetchedData != null) {
        _getbrandmodel = fetchedData;
        _brandModelController.add(fetchedData);
        Logger().i('Brand data fetched successfully');
      } else {
        _brandModelController.add(null);
        Logger().w('No brand data found');
      }
    } catch (e) {
      _brandModelController.addError(e);
      Logger().e('Error fetching brand data: $e');
    }
  }

  Future<void> fetchVehiclemodel(BuildContext context, int brandid) async {
    try {
      final fetchedData = await _api.GetVehicleModel(context, brandid);
      if (fetchedData != null) {
        _getvehiclemodel = fetchedData;
        _vehicleModelController.add(fetchedData);
        Logger().i('Vehicle models fetched successfully');
      } else {
        _vehicleModelController.add(null);
        Logger().w('No vehicle models found');
      }
    } catch (e) {
      _vehicleModelController.addError(e);
      Logger().e('Error fetching vehicle models: $e');
    }
  }

  @override
  void dispose() {
    _vehicleTypeController.close();
    _brandModelController.close();
    _vehicleModelController.close();
    super.dispose();
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
