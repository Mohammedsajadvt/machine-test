import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator; 
  
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
              ),
          enabledBorder: OutlineInputBorder(
              ),
          focusedBorder: OutlineInputBorder(
            
          ),
          fillColor: Colors.white10,
        ),
      ),
    );
  }
}
