

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class PopularProduct extends StatefulWidget {
//   const PopularProduct({
//     Key? key,
//     required this.width,
//     required this.product,
//     required this.onPressed,
//   }) : super(key: key);

//   final double width;
//   final Product product;
//   final VoidCallback onPressed;

//   @override
//   State<PopularProduct> createState() => _PopularProductState();
// }

// class _PopularProductState extends State<PopularProduct> {
//   bool iconColor = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onPressed,
//       child: Container(
//         width: 50.w,
//         height: 40.h,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: widget.width * 0.5,
//               height: widget.width * 0.5,
//               padding: const EdgeInsets.all(0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: const BorderRadius.all(Radius.circular(50)),
//               ),
//             child: ClipRRect( // Wrap the Image.network with ClipRRect
//               borderRadius: BorderRadius.circular(20), // Set circular border radius
//               child: Image.network(
//                 widget.product.advphoto,
//                 fit: BoxFit.cover, // Adjusted to make the image cover the container
//               ),
//             ),
//             ),
//             SizedBox(
//               width: widget.width * 0.55,
//               child: Text(
//                 widget.product.title,
//                 maxLines: 2,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'MyFont',
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 Text(
//                   widget.product.price,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: Color.fromARGB(200, 196, 176, 65),
//                   ),
//                 ),
//                 SizedBox(
//                   width: widget.width * 0.25,
//                 ),
//                 InkWell(
//                   onTap: (){
// FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
//       'favoriteProducts': FieldValue.arrayUnion([widget.product.advid]),


// });
// setState(() {
//   iconColor=!iconColor;
// });
//                   },
//                child: Container(
//                     width: widget.width * 0.075,
//                     height: widget.width * 0.1,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(31, 72, 48, 48),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
                      
//                       size: widget.width * 0.045,
//                       Icons.favorite,
//                       color: iconColor ? Color.fromARGB(200, 196, 176, 65) : Colors.black54,
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


// class Product {

//   final String title;
//   final String description;
//   final String price;
//   final String advid;
//   final String advphoto;

//   Product({
//     required this.title,
//     required this.advid,
//     required this.description,
//     required this.price,
//     required this.advphoto,
//   });

//   factory Product.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

//     if (data == null) {
//       throw Exception("Failed to parse Firestore data");
//     }

//     return Product(
//       advid: data['advid'] ?? '',
//       title: data['title'] ?? '',
//       description: data['description'] ?? '',
//       price: data['price'] ?? '',
//       advphoto: data['image'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'advid': advid,
//       'description': description,
//       'price': price,
//       advphoto: 'image',
//     };
//   }
// }
