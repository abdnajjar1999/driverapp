// import 'package:driver_durub/screens/details.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth to handle user authentication

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Authentication instance

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('الطلبات'),
//       ),
//       body: StreamBuilder<User?>(
//         stream: _auth.authStateChanges(), // Listen to the authentication state
//         builder: (context, authSnapshot) {
//           if (authSnapshot.hasError) {
//             return const Center(child: Text('Error retrieving user data.'));
//           }

//           if (authSnapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (authSnapshot.data == null) {
//             return const Center(child: Text('No user is logged in.'));
//           }

//           final currentUser = authSnapshot.data;

//           // Firestore query to get orders for the logged-in user
//           return StreamBuilder<QuerySnapshot>(
//             stream: _firestore
//                 .collection('orders')
//                 .where('userId', isEqualTo: currentUser!.uid) // Filter by the current user's ID
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return const Center(child: Text('Something went wrong'));
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               final orders = snapshot.data?.docs ?? [];

//               if (orders.isEmpty) {
//                 return const Center(child: Text('No orders found for this user.'));
//               }

//               return ListView.builder(
//                 itemCount: orders.length,
//                 itemBuilder: (context, index) {
//                   final order = orders[index];
//                   return ListTile(
//                     title: Text('رقم الطلب: ${order['رقم الطلب']}'),
//                     subtitle: Text('السعر: ${order['السعر']}'),
//                     onTap: () {
//                       // Navigate to the details screen, passing the order data
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DetailsScreen(orderData: order),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
