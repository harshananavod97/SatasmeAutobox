import 'package:flutter/material.dart';

class NegotiableStatusDropdown extends StatefulWidget {
  final void Function(int) onChanged;
  final int? defaultValue; // Add default value parameter

  const NegotiableStatusDropdown({
    Key? key,
    required this.onChanged,
    this.defaultValue, // Optional default value
  }) : super(key: key);

  @override
  State<NegotiableStatusDropdown> createState() =>
      _NegotiableStatusDropdownState();
}

class _NegotiableStatusDropdownState extends State<NegotiableStatusDropdown> {
  int? selectedValue;

  final Map<int, String> negotiableStatus = {
    1: 'Negotiable',
    0: 'None Negotiable',
  };

  @override
  void initState() {
    super.initState();
    // Set default value either from widget parameter or hardcoded value
    selectedValue = widget.defaultValue ??
        1; // Uses 1 ('Negotiable') as default if no value provided

    // Notify parent widget of initial value
    if (selectedValue != null) {
      widget.onChanged(selectedValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Negotiable Status',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      ),
      value: selectedValue,
      hint: const Text(
        'Select negotiable status',
        style: TextStyle(
            fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
      ),
      isExpanded: true,
      items: negotiableStatus.entries.map((entry) {
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
          return 'Please select negotiable status';
        }
        return null;
      },
    );
  }
}
