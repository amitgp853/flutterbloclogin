import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType textInputType;

  CustomTextField(
      {required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 65,
      child: TextField(
        obscureText: obscureText,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
      ),
    );
  }
}
