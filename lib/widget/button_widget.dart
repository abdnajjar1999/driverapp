import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.width,
    required this.callBack,
    required this.buttonText, // New parameter for button text
  });

  final double width;
  final VoidCallback callBack;
  final String buttonText; // New parameter for button text

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.8,
      height: 50,
      child: TextButton(
        onPressed: callBack,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 41, 0, 247)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
        child: Text(
          buttonText, // Use the new parameter here
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'MyFont',
          ),
        ),
      ),
    );
  }
}
