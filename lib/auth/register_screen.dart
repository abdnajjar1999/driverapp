import 'package:driver_durub/screens/complite_profile.dart';
import 'package:driver_durub/widget/buildtextformfield.dart';
import 'package:driver_durub/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth package
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordController1;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordController1 = TextEditingController();
  }

  Future<void> _createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Successfully created account
      print('User ID: ${userCredential.user!.uid}');

      // Navigate to another screen or perform other actions
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => CompleteProfileScreen()), // Replace with your desired screen
      );
    } catch (e) {
      // Handle account creation errors
      print('Error: $e');
      // Show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: [
                                    Container(
                        height: 30.h,
                        width: 100.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/alilogo.png'), // Replace with your background image path
              ),
            ),
          ),

              const Text(
                'Sign up Account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'MyFont',
                ),
              ),
              SizedBox(
                width: width * 0.5,
                child: const Text(
                  'Join us and experience fast reliable delivery',
                  style: TextStyle(color: Colors.black, fontFamily: 'MyFont'),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              
              SizedBox(height: height * 0.01),
              BuildTextFormField(
                width: width,
                hintText: 'Email',
                label: 'Enter your email',
                iconData: Icons.email_outlined,
                controller: emailController,
              ),
              SizedBox(height: height * 0.03),
              BuildTextFormField(
                width: width,
                label: 'Password',
                iconData: Icons.lock_outline,
                hintText: 'Enter your Password',
                controller: passwordController,
              ),
              SizedBox(height: height * 0.03),
              BuildTextFormField(
                width: width,
                label: 'Confirm password',
                iconData: Icons.lock_outline,
                hintText: 'Re-Enter your Password',
                controller: passwordController1,
              ),
              SizedBox(height: height * 0.04),
              SizedBox(
                width: 80.w,
                child: ButtonWidget(
                  width: width,
                  callBack: () {
                    if (passwordController.text ==
                        passwordController1.text) {
                      _createAccountWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Password and confirm password do not match'),
                        ),
                      );
                    }
                  }, buttonText: 'Sign up',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
