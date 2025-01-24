import 'package:flutter/material.dart';
import 'package:newautobox/Provider/LocationController.dart';
import 'package:newautobox/Provider/MyGragesController.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:provider/provider.dart';

import '../../../Model/DistrictModel.dart';

class MyDistrictDropDown extends StatefulWidget {
  final String District;
  const MyDistrictDropDown({Key? key, required this.District})
      : super(key: key);

  @override
  _MyDistrictDropDownState createState() => _MyDistrictDropDownState();
}

class _MyDistrictDropDownState extends State<MyDistrictDropDown> {
  int? selectedDistrictId;
  bool isLoading = true;
  bool isChangingDistrict = false;

  @override
  void initState() {
    super.initState();
    _initializeDistrict();
  }

  Future<void> _initializeDistrict() async {
    try {
      final controller =
          Provider.of<Locationcontroller>(context, listen: false);
      await controller.fetchProducts(context);

      if (!mounted) return;

      if (widget.District.isNotEmpty && controller.districtData != null) {
        final districts = controller.districtData!.data;
        final matchingDistrict = districts
            .where((district) => district.nameEn == widget.District)
            .firstOrNull;

        if (matchingDistrict != null) {
          setState(() => selectedDistrictId = matchingDistrict.id);
          await _loadCitiesForDistrict(
              matchingDistrict.id, matchingDistrict.nameEn);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load districts: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _loadCitiesForDistrict(
      int districtId, String districtName) async {
    if (isChangingDistrict) return;

    setState(() => isChangingDistrict = true);

    try {
      final controller =
          Provider.of<Locationcontroller>(context, listen: false);
      // Clear existing city data before fetching new ones
      controller.clearCityData();

      await controller.fetchCity(context, districtId);

      if (!mounted) return;

      Provider.of<MyGragesDataController>(context, listen: false)
        ..SetDistrict(districtName);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load cities: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isChangingDistrict = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Locationcontroller>(
      builder: (context, controller, _) {
        if (isLoading || controller.districtData == null) {
          return const Center(child: CircularProgressContainer());
        }

        final districts = controller.districtData!.data;
        if (districts.isEmpty) {
          return const Center(child: Text("No districts available"));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<int>(
                    value: selectedDistrictId,
                    isExpanded: true,
                    decoration: InputDecoration(
                      label: Text('District'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabled: !isChangingDistrict,
                    ),
                    menuMaxHeight: 300,
                    items: districts
                        .map((district) => DropdownMenuItem<int>(
                              value: district.id,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  district.nameEn,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: isChangingDistrict
                        ? null
                        : (value) async {
                            if (value == null) return;

                            setState(() => selectedDistrictId = value);

                            final district = districts.firstWhere(
                              (d) => d.id == value,
                              orElse: () => Datum(id: -1, nameEn: 'Not Found'),
                            );

                            if (district.id != -1) {
                              await _loadCitiesForDistrict(
                                  district.id, district.nameEn);
                            }
                          },
                    hint: Text(
                      widget.District.isEmpty
                          ? "Select District"
                          : widget.District,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    dropdownColor: Colors.white,
                  ),
                ),
                if (isChangingDistrict)
                  const Positioned.fill(
                    child: Center(child: CircularProgressContainer()),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
