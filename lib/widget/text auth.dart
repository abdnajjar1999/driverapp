
import 'package:flutter/material.dart';

class BuildTextFormField1 extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final String hintText;
  final String label;
  final IconData iconData;
  const BuildTextFormField1({
    super.key, required this.width, required this.hintText, required this.label, required this.iconData, required this.controller, required isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width*0.9,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior:FloatingLabelBehavior.always ,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey)
          ),
          label: Text(hintText,style: const TextStyle(fontFamily: 'MyFont'),),
          hintText: label,
          hintStyle: const TextStyle(fontFamily: 'MyFont'),
          suffixIcon: Icon(iconData),
          contentPadding: const EdgeInsets.only(left: 30,top: 40),
        ),
      ),
    );
  }
}


