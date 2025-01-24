// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/InqueryModel.dart';

class InqueryController extends ChangeNotifier {
  final ApiService _api = ApiService();
  final _dataController = StreamController<InqueryModel?>.broadcast();
  bool _isLoading = false;

  Stream<InqueryModel?> get dataStream => _dataController.stream;
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

      final fetchedData = await _api.GetUserInquery(userId, context);

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
