import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/GetGrageData.dart';

class GrageDataController extends ChangeNotifier {
  final ApiService _api = ApiService();
  final _dataController = StreamController<GetGrageData?>.broadcast();
  bool _isLoading = false;

  Stream<GetGrageData?> get dataStream => _dataController.stream;
  bool get isLoading => _isLoading;

  void dispose() {
    _dataController.close();
    super.dispose();
  }

  Future<void> fetchProducts(BuildContext context, String City) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      final fetchedData = await _api.GetGrageDat(context, City);

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
}
