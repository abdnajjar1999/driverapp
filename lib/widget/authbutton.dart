import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class ButtonWidget1 extends StatelessWidget {
  const ButtonWidget1({
    Key? key,
    required this.width,
    required this.callBack,
    this.buttonColor = Colors.black,
    this.buttonText = 'Continue',
    this.textColor = Colors.white,
    this.fontSize = 20,
    this.fontFamily = 'MyFont',
    this.icon,
    this.iconColor = Colors.white,
    this.iconSize = 24.0,
    this.image,
    this.fontWeight=FontWeight.w500,
    
  })
   : super(key: key);

  final double width;
  final VoidCallback callBack;
  final Color buttonColor;
  final String buttonText;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;
  final IconData? icon; // Nullable icon data
  final Color iconColor;
  final double iconSize;
  final ImageProvider? image; // Nullable image data

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 7.h,
      child: TextButton(
        onPressed: callBack,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            if (icon != null) // Show icon if it's provided
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w), // Add some space between icon/image and text
                child: Icon(
                  icon,
                  color: iconColor,
                  size: iconSize,
                ),
              ),
            if (image != null) // Show image if it's provided
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w), // Add some space between icon/image and text
                child: Image(image: image!, width: 24.0, height: 24.0),
              ),
            Expanded(
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontWeight:FontWeight.w500,
                    color: textColor,
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
