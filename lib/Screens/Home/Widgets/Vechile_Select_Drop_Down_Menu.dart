import 'package:flutter/material.dart';
import 'package:newautobox/Provider/GetVehicleControllers.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:provider/provider.dart';

class VehicleTypesDropDown extends StatefulWidget {
  const VehicleTypesDropDown({Key? key}) : super(key: key);

  @override
  _VehicleTypesDropDownState createState() => _VehicleTypesDropDownState();
}

class _VehicleTypesDropDownState extends State<VehicleTypesDropDown> {
  String? selectedValue;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeVehicleTypes();
  }

  Future<void> _initializeVehicleTypes() async {
    try {
      await Provider.of<Getvehiclecontrollers>(context, listen: false)
          .fetchVechicleType(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to load vehicle types: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _handleVehicleTypeChange(String? value) async {
    if (value == null) return;

    setState(() {
      isLoading = true;
      selectedValue = value;
    });

    try {
      final controller =
          Provider.of<Getvehiclecontrollers>(context, listen: false);
      await controller.fetchBrandType(context, int.parse(value));
      controller.SetVehicleId(int.parse(value));
    } catch (e) {
      if (mounted) {
        setState(() {
          selectedValue = null; // Reset on error
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load brands: ${e.toString()}')),
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

  @override
  Widget build(BuildContext context) {
    return Consumer<Getvehiclecontrollers>(
      builder: (context, controller, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            StreamBuilder(
              stream: controller.vehicleTypeStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressContainer());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading vehicle types: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data?.data == null) {
                  return const Center(
                    child: Text(
                      "No vehicle types available",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                final vehicleTypes = snapshot.data!.data;
                final uniqueVehicleTypes = {
                  for (var vehicle in vehicleTypes)
                    vehicle.id.toString(): vehicle.vtName,
                }..removeWhere((key, value) =>
                    value == null || value.isEmpty || key.isEmpty);

                return Stack(
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedValue,
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
                        enabled: !isLoading,
                      ),
                      menuMaxHeight: 300,
                      items: uniqueVehicleTypes.entries
                          .map((entry) => DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: isLoading ? null : _handleVehicleTypeChange,
                      hint: const Text(
                        "Select Vehicle Type",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isLoading)
                      const Positioned.fill(
                        child: Center(
                          child: CircularProgressContainer(),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
