import 'package:driver_durub/auth/register_screen.dart';
import 'package:driver_durub/screens/home.dart';
import 'package:driver_durub/widget/buildtextformfield.dart';
import 'package:driver_durub/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth package
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static const screenRoute = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Successfully signed in
      print('User ID: ${userCredential.user!.uid}');
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Homescreen( )),
      );
    } catch (e) {
      // Handle sign-in errors
      print('Error: $e');

      // Show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 5), // Adjust the duration as needed
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 18.h,),
                      Container(
                        height: 30.h,
                        width: 70.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/alilogo.png'), // Replace with your background image path
              ),
            ),
          ),

            const Text(
              'Welcome Back',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 30,
              ),
            ),
            SizedBox(
              width: width * 0.6,
              child: const Text(
                'Sign in with your email & password',
                style: TextStyle(color: Colors.black, fontFamily: 'MyFont'),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                BuildTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  width: width,
                  hintText: 'Email',
                  iconData: Icons.email_outlined,
                  label: 'Enter your email',
                  controller: emailController,
                ),
                SizedBox(height: height * 0.04),
                BuildTextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  width: width,
                  hintText: 'Password',
                  iconData: Icons.lock_outline,
                  label: 'Enter your password',
                  controller: passwordController,
                ),
                SizedBox(height: height * 0.03),
                ButtonWidget(
                  width: width,
                  callBack: () {
                    _signInWithEmailAndPassword(); // Call the sign-in method
                  }, buttonText: 'Login',
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.black, fontFamily: 'MyFont'),
                ),
                InkWell(
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Color.fromARGB(255, 41, 0, 247), fontFamily: 'MyFont'),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => RegisterScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
