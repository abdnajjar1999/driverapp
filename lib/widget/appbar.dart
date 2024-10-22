// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:petra_shop/screens/profile/profile_screen.dart';
// import 'package:sizer/sizer.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize => Size.fromHeight(4.h); // Adjust the height as needed

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       actions:[IconButton(onPressed: (){          Navigator.of(context).push(
//             MaterialPageRoute(
//                 builder: (_) => ProfileScreen()
//                 ),
//           );
// }, icon: Icon(Icons.person_outlined),color:Color.fromARGB(200, 196, 176, 65),iconSize: 22,),],
//       automaticallyImplyLeading: false,
//       title: Text(
//         'PETRA',
//         style: TextStyle(
//           fontSize: 23,
//           fontWeight: FontWeight.w600,
//           color: Color.fromARGB(200, 196, 176, 65),
//           fontStyle: FontStyle.italic
//         ),
//       ),
//       centerTitle: true,
//     );
//   }
// }
