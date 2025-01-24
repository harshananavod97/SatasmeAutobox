import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/AllAdsModel.dart';

class AllAdsController extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool _isLoading = false;
  bool _isLoadings = false;
  final StreamController<AllAddModel?> _adsStreamController =
      StreamController<AllAddModel?>.broadcast();

  bool get isLoading => _isLoading;

  bool get isLoadings => _isLoading;

  Stream<AllAddModel?> get adsStream => _adsStreamController.stream;

  Future<void> fetchProducts(
      BuildContext context, int vechicleId, int brandId, int modelId) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      final fetchedData =
          await _api.GetAds(vechicleId, brandId, modelId, context);

      if (fetchedData != null) {
        _adsStreamController.add(fetchedData); // Emit new data
        Logger().i('Ads data fetched successfully');
      } else {
        Logger().w('No ads data found');
        _adsStreamController.add(null);
      }
    } catch (e) {
      Logger().e('Error fetching ads data: $e');
      _adsStreamController.addError(e); // Emit error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSearchAds(BuildContext context, String itemname) async {
    if (_isLoading) return;

    try {
      _isLoadings = true;
      notifyListeners();

      final fetchedData = await _api.GeSearchtAds(itemname, context);

      if (fetchedData != null) {
        _adsStreamController.add(fetchedData); // Emit new data
        Logger().i('Ads data fetched successfully');
      } else {
        Logger().w('No ads data found');
        _adsStreamController.add(null);
      }
    } catch (e) {
      Logger().e('Error fetching ads data: $e');
      _adsStreamController.addError(e); // Emit error
    } finally {
      _isLoadings = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _adsStreamController.close(); // Close the stream
    super.dispose();
  }
}
