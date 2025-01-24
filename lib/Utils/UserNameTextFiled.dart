import 'package:flutter/material.dart';
import 'package:newautobox/Utils/Validators.dart';

class UserNameTextFiled extends StatelessWidget {
  const UserNameTextFiled({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hintText = "Enter User Name";

    return TextFormField(
      cursorColor: colorScheme.onTertiary,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: (val) => Validators.validateUserName(
          val!,
          'User Name is Required',
          'Username  must be at least 8 characters long.'),
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        fillColor: colorScheme.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        prefixIconColor: colorScheme.onTertiary.withOpacity(0.4),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: const EdgeInsets.all(16),
        errorStyle: const TextStyle(
          color: Colors.white, // Set error text color to white
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
