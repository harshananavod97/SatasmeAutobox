import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newautobox/Provider/GetVehicleControllers.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:provider/provider.dart';

class VehicleBrandDropDown extends StatefulWidget {
  final String brad;

  const VehicleBrandDropDown({Key? key, required this.brad}) : super(key: key);

  @override
  _VehicleBrandDropDownState createState() => _VehicleBrandDropDownState();
}

class _VehicleBrandDropDownState extends State<VehicleBrandDropDown> {
  int? selectedBrandId;
  bool isLoading = false;
  Map<int, String> currentBrands = {};

  @override
  void didUpdateWidget(VehicleBrandDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.brad != oldWidget.brad) {
      _resetSelection();
    }
  }

  void _resetSelection() {
    setState(() {
      selectedBrandId = null;
      currentBrands.clear();
    });

    final controller =
        Provider.of<Getvehiclecontrollers>(context, listen: false);
    controller.SetBrandID(1);
    controller.SetVehicleBrandName('');
  }

  Future<void> _handleBrandChange(int? value) async {
    if (value == null || !currentBrands.containsKey(value)) return;

    setState(() {
      isLoading = true;
      selectedBrandId = value;
    });

    try {
      final controller =
          Provider.of<Getvehiclecontrollers>(context, listen: false);
      await controller.fetchVehiclemodel(context, value);
      controller.SetBrandID(value);
      controller.SetVehicleBrandName(currentBrands[value] ?? '');
    } catch (e) {
      if (mounted) {
        setState(() {
          selectedBrandId = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load models: ${e.toString()}')),
        );
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
    return currentBrands.entries.map((entry) {
      return DropdownMenuItem<int>(
        key: ValueKey('brand_${entry.key}'),
        value: entry.key,
        child: Text(
          entry.value,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Getvehiclecontrollers>(
      builder: (context, controller, _) {
        return StreamBuilder(
          stream: controller.brandModelStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Container());
            }

            if (snapshot.hasError) {
              return _buildErrorContainer(snapshot.error.toString());
            }

            if (!snapshot.hasData || snapshot.data?.brands == null) {
              return _buildEmptyContainer("No Brands Available");
            }

            // Update current brands map
            currentBrands.clear();
            for (var brand in snapshot.data!.brands) {
              if (brand.brandId != null &&
                  brand.brandName != null &&
                  brand.brandName.isNotEmpty) {
                currentBrands[brand.brandId!] = brand.brandName!;
              }
            }

            // Validate selectedBrandId
            if (selectedBrandId != null &&
                !currentBrands.containsKey(selectedBrandId)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    selectedBrandId = null;
                  });
                }
              });
            }

            if (currentBrands.isEmpty) {
              return _buildEmptyContainer("No Brands Available");
            }

            final dropdownItems = _buildDropdownItems();

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: DropdownButtonFormField<int>(
                    key: ValueKey('brand_dropdown_${currentBrands.length}'),
                    value: currentBrands.containsKey(selectedBrandId)
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
                    onChanged: isLoading ? null : _handleBrandChange,
                    hint: Text(
                      widget.brad.isEmpty ? "Select brand" : widget.brad,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
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
}
