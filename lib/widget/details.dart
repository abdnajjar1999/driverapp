import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;

  const PhotoContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.imagePath,
  }) : super(key: key);
 


 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
