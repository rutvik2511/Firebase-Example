import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.black87),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: const OutlineInputBorder()),
    );
  }
}
