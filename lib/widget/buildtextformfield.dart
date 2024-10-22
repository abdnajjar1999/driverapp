import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  final double width;
  final String hintText;
  final String label;
  final IconData iconData;
  final TextEditingController? controller;
  final TextInputType? keyboardType; // Added keyboardType parameter
  final int? maxLines; // Added maxLines parameter

  const BuildTextFormField({
    required this.width,
    required this.hintText,
    required this.label,
    required this.iconData,
    this.controller,
    this.keyboardType, // Added keyboardType parameter
    this.maxLines = 1, // Default value is 1 line
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.8,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        maxLines: maxLines, // Set the maxLines parameter
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black),
          prefixIconColor: Color.fromARGB(255, 41, 0, 247),
          fillColor: Colors.black,
          hintText: hintText,
          labelText: label,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black, // Border color when focused
            ),
          ),
        ),
      ),
    );
  }
}
