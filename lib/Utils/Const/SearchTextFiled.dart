import 'package:flutter/material.dart';

class SearchTextFiled extends StatelessWidget {
  const SearchTextFiled({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hintText = "Choose Your Vehicle";

    return TextFormField(
      cursorColor: colorScheme.onTertiary,
      controller: controller,
      keyboardType: TextInputType.name,
      style: TextStyle(
          color: Color(0xFF7F7D7D), fontSize: 18, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        fillColor: Color(0xffD9D9D9),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(
          Icons.adjust,
          color: Color(0xFF7F7D7D),
        ),
        prefixIconColor: colorScheme.onTertiary.withOpacity(0.4),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xFF7F7D7D),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}

class SearchTextFiled2 extends StatelessWidget {
  const SearchTextFiled2({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hintText = "Choose Your Vehicle model";

    return TextFormField(
      cursorColor: colorScheme.onTertiary,
      controller: controller,
      keyboardType: TextInputType.name,
      style: TextStyle(
          color: Color(0xFF7F7D7D), fontSize: 18, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        fillColor: Color(0xffD9D9D9),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(
          Icons.adjust,
          color: Color(0xFF7F7D7D),
        ),
        prefixIconColor: colorScheme.onTertiary.withOpacity(0.4),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xFF7F7D7D),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
