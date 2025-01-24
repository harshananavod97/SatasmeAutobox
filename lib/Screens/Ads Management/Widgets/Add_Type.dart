import 'package:flutter/material.dart';

class AdTypeDropdown extends StatefulWidget {
  final void Function(int) onChanged;
  final int? defaultValue;

  const AdTypeDropdown({
    Key? key,
    required this.onChanged,
    this.defaultValue,
  }) : super(key: key);

  @override
  State<AdTypeDropdown> createState() => _AdTypeDropdownState();
}

class _AdTypeDropdownState extends State<AdTypeDropdown> {
  int? selectedValue;

  final Map<int, String> adTypes = {
    1: 'Top Add',
    0: 'Normal Add',
  };

  @override
  void initState() {
    super.initState();
    // Set default value either from widget parameter or 0 (Normal Add)
    selectedValue = widget.defaultValue ?? 0;

    // Notify parent widget of initial value
    widget.onChanged(selectedValue!);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Advertisement Type',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      ),
      value: selectedValue,
      hint: const Text(
        'Select advertisement type',
        style: TextStyle(
            fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
      ),
      isExpanded: true,
      items: adTypes.entries.map((entry) {
        return DropdownMenuItem<int>(
          value: entry.key,
          child: Text(
            entry.value,
            style: const TextStyle(
                fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
          ),
        );
      }).toList(),
      onChanged: (int? newValue) {
        setState(() {
          selectedValue = newValue;
        });
        if (newValue != null) {
          widget.onChanged(newValue);
        }
      },
      validator: (value) {
        if (value == null) {
          return 'Please select an advertisement type';
        }
        return null;
      },
    );
  }
}
