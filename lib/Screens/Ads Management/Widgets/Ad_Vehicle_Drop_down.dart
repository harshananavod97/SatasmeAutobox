import 'package:flutter/material.dart';
import 'package:newautobox/Provider/GetVehicleControllers.dart';
import 'package:newautobox/Provider/MyAdController.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:provider/provider.dart';

class AdVehicleTypesDropDown extends StatefulWidget {
  String vname;
  AdVehicleTypesDropDown({Key? key, required this.vname}) : super(key: key);

  @override
  _AdVehicleTypesDropDownState createState() => _AdVehicleTypesDropDownState();
}

class _AdVehicleTypesDropDownState extends State<AdVehicleTypesDropDown> {
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
      final controller2 = Provider.of<MyAdController>(context, listen: false);
      await controller.fetchBrandType(context, int.parse(value));
      controller2.SetVehicleId(int.parse(value));
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
                        label: Text('Vehicle Type'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
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
                      hint: Text(
                        widget.vname.isEmpty
                            ? "Select Vehicle Type"
                            : widget.vname,
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
