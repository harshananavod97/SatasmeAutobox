import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Model/vehicleModles.dart';
import 'package:newautobox/Provider/GetVehicleControllers.dart';
import 'package:newautobox/Provider/allAdsController.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:provider/provider.dart';

class Vehiclemodeldropdown extends StatefulWidget {
  final String brad;

  const Vehiclemodeldropdown({Key? key, required this.brad}) : super(key: key);

  @override
  _VehiclemodeldropdownState createState() => _VehiclemodeldropdownState();
}

class _VehiclemodeldropdownState extends State<Vehiclemodeldropdown> {
  int? selectedBrandId;
  bool isLoading = false;
  Map<int, String> currentModels = {};
  final logger = Logger();

  @override
  void didUpdateWidget(Vehiclemodeldropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.brad != oldWidget.brad) {
      _resetSelection();
    }
  }

  void _resetSelection() {
    setState(() {
      selectedBrandId = null;
      currentModels.clear();
    });

    final controller =
        Provider.of<Getvehiclecontrollers>(context, listen: false);
    controller.SetModelID(1);
  }

  Future<void> _handleModelChange(int? value) async {
    if (value == null || !currentModels.containsKey(value)) return;

    setState(() {
      isLoading = true;
      selectedBrandId = value;
    });

    try {
      final vehicleData =
          Provider.of<Getvehiclecontrollers>(context, listen: false);
      vehicleData.SetModelID(value);

      final addPackageController =
          Provider.of<AllAdsController>(context, listen: false);
      final vehicleId = vehicleData.Vehicleid;
      final brandId = vehicleData.BrandID;

      logger.i("Vehicle ID: $vehicleId, Brand ID: $brandId, Model ID: $value");

      if (vehicleId != null && brandId != null) {
        await addPackageController.fetchProducts(
          context,
          vehicleId,
          brandId,
          value,
        );
      } else {
        throw Exception("Vehicle ID or Brand ID is null");
      }
    } catch (e, stackTrace) {
      if (mounted) {
        setState(() {
          selectedBrandId = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load products: ${e.toString()}')),
        );
        logger.e("Error fetching products", error: e, stackTrace: stackTrace);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  List<DropdownMenuItem<int>> _buildDropdownItems() {
    return currentModels.entries.map((entry) {
      return DropdownMenuItem<int>(
        key: ValueKey('model_${entry.key}'),
        value: entry.key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            entry.value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildEmptyContainer(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorContainer(String error) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Error: $error',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Getvehiclecontrollers>(
      builder: (context, controller, _) {
        return StreamBuilder<VehicleModel?>(
          stream: controller.vehicleModelStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Container());
            }

            if (snapshot.hasError) {
              logger.e('Error fetching vehicle models: ${snapshot.error}');
              return _buildErrorContainer(snapshot.error.toString());
            }

            final modelList = snapshot.data?.model ?? [];
            if (modelList.isEmpty) {
              return _buildEmptyContainer("No Models Available");
            }

            // Update current models map
            currentModels.clear();
            for (var model in modelList) {
              if (model.id != null &&
                  model.modelName != null &&
                  model.modelName!.isNotEmpty) {
                currentModels[model.id] = model.modelName!;
              }
            }

            // Validate selectedBrandId
            if (selectedBrandId != null &&
                !currentModels.containsKey(selectedBrandId)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    selectedBrandId = null;
                  });
                }
              });
            }

            if (currentModels.isEmpty) {
              return _buildEmptyContainer("No Models Available");
            }

            final dropdownItems = _buildDropdownItems();

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      key: ValueKey('model_dropdown_${currentModels.length}'),
                      value: currentModels.containsKey(selectedBrandId)
                          ? selectedBrandId
                          : null,
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabled: !isLoading && dropdownItems.isNotEmpty,
                      ),
                      menuMaxHeight: 300,
                      items: dropdownItems,
                      onChanged: isLoading ? null : _handleModelChange,
                      hint: Text(
                        widget.brad.isEmpty ? "Select Model" : widget.brad,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      dropdownColor: Colors.white,
                    ),
                  ],
                ),
                if (isLoading)
                  const Positioned.fill(
                    child: Center(child: CircularProgressContainer()),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
