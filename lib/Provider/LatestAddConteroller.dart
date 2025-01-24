import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/LatestAdsModel.dart';

class LatestAdsController extends ChangeNotifier {
  final ApiService _api = ApiService();
  final StreamController<LatestAdsModel?> _dataController =
      StreamController<LatestAdsModel?>.broadcast();
  bool _isLoading = false;

  /// Public getters
  Stream<LatestAdsModel?> get dataStream => _dataController.stream;
  bool get isLoading => _isLoading;

  /// Dispose method to close the stream properly
  @override
  void dispose() {
    if (!_dataController.isClosed) {
      _dataController.close();
    }
    super.dispose();
  }

  /// Fetch products method
  Future<void> fetchProducts(BuildContext context) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners(); // Notify listeners that loading has started

    try {
      final fetchedData = await _api.GetLatestAdd(context);

      if (fetchedData != null) {
        _dataController.add(fetchedData);
        Logger().i('Latest ads fetched successfully');
      } else {
        _dataController.add(null);
        Logger().w('No latest ads data found');
      }
    } catch (e) {
      Logger().e('Error fetching latest ads: $e');
      _dataController.addError(e);
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has ended
    }
  }
}
