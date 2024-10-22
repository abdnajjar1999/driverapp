
// import 'package:flutter/material.dart';

// class SpecialForYou extends StatelessWidget {

//   const SpecialForYou({
//     super.key,
//     required this.width,
//     required this.height, required this.title, required this.subTitle, required this.path,
//   });

//   final double width;
//   final double height;
//   final String title;
//   final String subTitle;
//   final String path;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: width*0.7,
//           height: height*0.15,
//           decoration: const BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.all(Radius.circular(25))
//           ),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.all(Radius.circular(25)),
//             child: Image.asset(fit: BoxFit.cover,path),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(10),
//           height: height*.15,
//           width: width*0.7,
//           alignment: Alignment.topLeft,
//           decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(25)),
//             gradient: LinearGradient(
//               begin: Alignment.bottomCenter,
//               end: Alignment.topCenter,
//               colors: [
//                 Colors.black.withOpacity(0.1),
//                 Colors.black.withOpacity(0.5)
//               ]
//             )
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.055,fontFamily: 'MyFont',color: Colors.white),),
//               Text(subTitle,style: const TextStyle(color: Colors.white,fontFamily: 'MyFont'),)
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
