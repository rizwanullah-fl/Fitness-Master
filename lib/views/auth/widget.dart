import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final RxString controller;
  final String labelText;
  final bool isPassword;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => controller.value = value,
      obscureText: isPassword, // Obscure text if it's a password field
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pink),
        ),
      ),
    );
  }
}
