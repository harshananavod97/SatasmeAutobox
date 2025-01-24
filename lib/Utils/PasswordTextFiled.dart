import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newautobox/Utils/Validators.dart';

class PswdTextField extends StatefulWidget {
  const PswdTextField({
    required this.controller,
    super.key,
    this.validator,
    this.hintText,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;

  @override
  State<PswdTextField> createState() => _PswdTextFieldState();
}

class _PswdTextFieldState extends State<PswdTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      obscureText: _obscureText,
      obscuringCharacter: '*',
      validator: (val) => Validators.validPassword(
        val!,
        'Password is required',
        'Password must be 6-20 characters & Strong',
      ),
      decoration: InputDecoration(
        fillColor: theme.colorScheme.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(15),
        hintText: widget.hintText ?? 'Enter Your Password',
        hintStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        prefixIcon: Icon(
          CupertinoIcons.lock,
          color: Colors.black,
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onTap: () => setState(() => _obscureText = !_obscureText),
        ),
        errorStyle: const TextStyle(
          color: Colors.white, // Set error text color to white
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
