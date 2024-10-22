import 'dart:io';
import 'package:driver_durub/screens/home.dart';
import 'package:driver_durub/widget/buildtextformfield.dart';
import 'package:driver_durub/widget/button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);
  static const screenRoute = '/complete-screen';

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String? _currentPhotoPath;
  String? _photoPathFromFirebase;

  late User? user;
  late String email;
  late String userId; // User ID

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid; // Fetch user ID
    email = user!.email ?? "";
    _getUserProfile();
  }

  Future<String> uploadImageToFirebaseStorage(File image) async {
    try {
      User? fireUser = FirebaseAuth.instance.currentUser;

      Reference storageReference = FirebaseStorage.instance.ref().child('user_profile_pictures/${fireUser!.uid}.jpg');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => print('Image uploaded'));
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
    }
    return '';
  }

  Future<void> _pickImage(ImageSource source) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        maxWidth: 150,
      );
      _photoPathFromFirebase =
          await uploadImageToFirebaseStorage(File(pickedImage!.path));
      if (pickedImage != null) {
        setState(() {
          _currentPhotoPath = pickedImage.path;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Error picking image. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      Navigator.pop(context); // Close the loading indicator
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Take a Photo'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveProfileData(
      String email, String username, String phoneNumber, int selectedCityIndex,
      {String? address}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('drivers');

    if (userId.isNotEmpty) { // Check if userId is not empty
      String photoUrl = _photoPathFromFirebase ?? ''; // Get the uploaded photo URL

      await users.doc(userId).set({
        'userid':userId,
        'profileImage': photoUrl,
        'phone number': phoneNumber,
        'email': email,
        'username': username,
        'address': address ?? "",
      });
    }
  }

  Future<void> _getUserProfile() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    if (user != null) {
      DocumentSnapshot snapshot = await users.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('profileImage')) {
          setState(() {
            _photoPathFromFirebase = data['profileImage'] as String?;
          });
        } else {
          print('Profile image not found in user data');
        }
      } else {
        print('User profile not found');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => _showImagePickerOptions(),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: _currentPhotoPath != null
                      ? ClipOval(
                          child: Image.file(
                            File(_currentPhotoPath!),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                ),
              ),
              const Text(
                'Driver image',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MyFont'),
              ),
                            SizedBox(
                height: height * 0.06,
              ),

              SizedBox(
                width: width * 0.5,
                child: const Text(
                  'Complete your details',
                  style: TextStyle(color: Colors.grey, fontFamily: 'MyFont'),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              BuildTextFormField(
                width: width,
                hintText: 'Driver Name',
                iconData: Icons.person,
                label: 'Enter your Name',
                controller: firstNameController,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              BuildTextFormField(
                keyboardType:TextInputType.phone ,
                width: width,
                hintText: 'Phone Number',
                iconData: Icons.phone_android,
                label: 'Enter your phone number',
                controller: phoneNumberController,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              BuildTextFormField(
                width: width,
                hintText: 'Address',
                iconData: Icons.location_on,
                label: 'Enter your address',
                controller: addressController,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ButtonWidget(
                width: width,
                callBack: () {
                 if (_currentPhotoPath!=null){ // Check if photo is uploaded
                    _saveProfileData(
                      email,
                      '${firstNameController.text} ${lastNameController.text}',
                      phoneNumberController.text,
                      0, // Adjust the index according to your needs
                      address: addressController.text,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => Homescreen(
                      ),
                    )
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Please upload a photo.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }, buttonText: 'Supmit',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              const SizedBox(height: 10)
            ],
          )
        ],
      ),
    );
  }
}
