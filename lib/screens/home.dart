import 'package:driver_durub/screens/details.dart'; // Import the details screen
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:geolocator/geolocator.dart';

// Order model
class CustomOrder {
  final String orderId;
  final String customerName;
  final String region;
  final double price;
  final String notes;
  final String description;
  final String driverId;
  final String profileImageUrl;
  final DateTime timestamp;
  final String userId;
  final String username;
  final String status;

  CustomOrder({
    required this.orderId,
    required this.customerName,
    required this.region,
    required this.price,
    required this.notes,
    required this.description,
    required this.driverId,
    required this.profileImageUrl,
    required this.timestamp,
    required this.userId,
    required this.username,
    required this.status,
  });

  factory CustomOrder.fromMap(Map<String, dynamic> data, String documentId) {
    return CustomOrder(
      orderId: documentId,
      customerName: data['اسم العميل'] ?? '',
      region: data['المنطقة'] ?? '',
      price: data['السعر'] ?? 0.0,
      notes: data['الملاحظات'] ?? '',
      description: data['مواصفات الطلب'] ?? '',
      driverId: data['driverId'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      userId: data['userId'] ?? '',
      username: data['username'] ?? '',
      status: data['status'] ?? 'Pending',
    );
  }
}

class Homescreen extends StatefulWidget {
  static const screenRoute = '/home';

  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? username;
  String? profileImageUrl;
  List<CustomOrder> orders = []; // Use CustomOrder instead of Order

  // Fetch user data
  Future<void> _getUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await _firestore.collection('drivers').doc(currentUser.uid).get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

        setState(() {
          username = userData != null && userData.containsKey('username') 
            ? userData['username'] 
            : 'Guest User';
          profileImageUrl = userData?['profileImage'] ?? 'https://via.placeholder.com/150';
        });
      }
    }
  }

  trackLocation() async {
    var location = await _determinePosition();
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      DocumentReference driverRef = _firestore.collection('drivers').doc(currentUser.uid);

      // Check if the driver's document exists
      DocumentSnapshot driverDoc = await driverRef.get();

      if (!driverDoc.exists) {
        // Create a new document for the driver with their initial location
        await driverRef.set({
          "username": username ?? 'Guest User',
          "profileImage": profileImageUrl ?? 'https://via.placeholder.com/150',
          "location": "${location.latitude},${location.longitude}",
        });
      } else {
        // Update the existing document with the driver's location
        await driverRef.update({
          "location": "${location.latitude},${location.longitude}",
        });
      }
    }
  }

  // Fetch orders for the driver
  Future<void> _fetchOrders() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      QuerySnapshot orderSnapshot = await _firestore
          .collection('orders')
          .where('driverName', isEqualTo: currentUser.uid)
          .get();

      setState(() {
        orders = orderSnapshot.docs.map((doc) {
          return CustomOrder.fromMap(doc.data() as Map<String, dynamic>, doc.id); // Update here
        }).toList();
      });
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
    _fetchOrders(); 
    trackLocation(); // Fetch location for the driver
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'الطلبات',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.blue.shade800],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        profileImageUrl ?? 'https://via.placeholder.com/150',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      username ?? 'Guest User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _auth.currentUser?.email ?? '',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
              title: Text('About Us'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Your App Name',
                  applicationVersion: '1.0.0',
                  applicationIcon: Icon(Icons.info_outline),
                  children: [
                    Text('This app is designed to help you manage orders seamlessly.'),
                  ],
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout'),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: orders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No orders found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(order: order),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(order.profileImageUrl),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.customerName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, 
                                        size: 16, 
                                        color: Colors.grey[600]
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        order.region,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: order.status == 'Pending' 
                                        ? Colors.orange.withOpacity(0.2)
                                        : Colors.green.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      order.status,
                                      style: TextStyle(
                                        color: order.status == 'Pending'
                                            ? Colors.orange[800]
                                            : Colors.green[800],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // Request permission if not already granted
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied');
  }

  // Get the current location
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
