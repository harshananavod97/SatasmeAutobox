import 'package:flutter/material.dart';

class ConditionDropdown extends StatefulWidget {
  final void Function(String?) onChanged;
  final String? defaultValue;

  const ConditionDropdown({
    Key? key, 
    required this.onChanged,
    this.defaultValue,
  }) : super(key: key);

  @override
  State<ConditionDropdown> createState() => _ConditionDropdownState();
}

class _ConditionDropdownState extends State<ConditionDropdown> {
  String? selectedCondition;
  final List<String> conditions = ['Brand New', 'Used'];

  @override
  void initState() {
    super.initState();
    // Set default value either from widget parameter or first item in list
    selectedCondition = widget.defaultValue ?? conditions[0];
    
    // Notify parent widget of initial value
    widget.onChanged(selectedCondition);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Item Condition',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      ),
      value: selectedCondition,
      hint: const Text(
        'Select condition',
        style: TextStyle(
          fontStyle: FontStyle.normal, 
          fontWeight: FontWeight.normal
        ),
      ),
      isExpanded: true,
      items: conditions.map((String condition) {
        return DropdownMenuItem<String>(
          value: condition,
          child: Text(
            condition,
            style: const TextStyle(
              fontStyle: FontStyle.normal, 
              fontWeight: FontWeight.normal
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCondition = newValue;
        });
        widget.onChanged(newValue);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a condition';
        }
        return null;
      },
    );
  }
}