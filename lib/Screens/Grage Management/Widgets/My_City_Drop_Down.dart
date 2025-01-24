import 'package:flutter/material.dart';
import 'package:newautobox/Provider/GarageDataController.dart';
import 'package:newautobox/Provider/LocationController.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:provider/provider.dart';

import '../../../Provider/MyGragesController.dart';

class MyCityDropDown extends StatefulWidget {
  final String city;
  const MyCityDropDown({Key? key, required this.city}) : super(key: key);

  @override
  _MyCityDropDownState createState() => _MyCityDropDownState();
}

class _MyCityDropDownState extends State<MyCityDropDown> {
  int? selectedCityId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeCity();
  }

  @override
  void didUpdateWidget(MyCityDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.city != oldWidget.city) {
      _initializeCity();
    }
  }

  void _initializeCity() {
    if (widget.city.isEmpty) {
      setState(() => selectedCityId = null);
      return;
    }

    final controller = context.read<Locationcontroller>();
    if (controller.cityData?.data == null) return;

    // Reset selection if city not found in current data
    final matchingCity = controller.cityData!.data
        .where((city) => city.nameEn == widget.city)
        .firstOrNull;

    setState(() => selectedCityId = matchingCity?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Locationcontroller>(
      builder: (context, controller, _) {
        // Show placeholder when no city data is available
        if (controller.cityData == null) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
            ),
            child: Text(widget.city == '' ? 'Select City' : widget.city),
          );
        }

        final cities = controller.cityData!.data;
        if (cities.isEmpty) {
          return const SizedBox(
            height: 60,
            child: Center(child: Text("No cities available for this district")),
          );
        }

        // Ensure selected city exists in current list
        if (selectedCityId != null &&
            !cities.any((city) => city.id == selectedCityId)) {
          selectedCityId = null;
        }

        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<int>(
                value: selectedCityId,
                isExpanded: true,
                decoration: InputDecoration(
                  label: Text('City'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
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
                items: cities
                    .map((city) => DropdownMenuItem<int>(
                          value: city.id,
                          child: Text(
                            city.nameEn,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: isLoading
                    ? null
                    : (value) async {
                        if (value == null) return;

                        setState(() {
                          selectedCityId = value;
                          isLoading = true;
                        });

                        try {
                          final selectedCity = cities.firstWhere(
                            (city) => city.id == value,
                            orElse: () => cities.first,
                          );

                          final userController =
                              context.read<MyGragesDataController>();
                          userController..SetCity(selectedCity.nameEn);

                          await context
                              .read<GrageDataController>()
                              .fetchProducts(
                                context,
                                userController.City.toString(),
                              );
                        } finally {
                          if (mounted) {
                            setState(() => isLoading = false);
                          }
                        }
                      },
                hint: Text(
                  widget.city.isEmpty ? "Select City" : widget.city,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                dropdownColor: Colors.white,
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
  }
}
