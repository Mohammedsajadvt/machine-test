import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: const Color(0xffF9F9F9),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white10)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white10),
          ),
          fillColor: Colors.white10,
        ),
      ),
    );
  }
}
