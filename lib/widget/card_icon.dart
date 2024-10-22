
// import 'package:flutter/material.dart';

// class CardOfIcon extends StatelessWidget {
//   const CardOfIcon({
//     super.key,
//     required this.width, required this.path, required this.textOfCard,
//   });

//   final double width;
//   final String path;
//   final String textOfCard;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding:  EdgeInsets.all(width*0.03),
//           width: width*0.14,
//           height: width*0.14,
//           decoration:  BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(width*0.03)),
//               color: Colors.pink[50]
//           ),
//           child: setIcon(path),
//         ),
//         SizedBox(height: width*0.01,),
//         SizedBox(
//             width: width*0.14,
//             height: width*0.14,
//             child: Text(textOfCard,textAlign: TextAlign.center,style: const TextStyle(fontFamily: 'MyFont',color: Colors.grey),))
//       ],
//     );
//   }
// }
