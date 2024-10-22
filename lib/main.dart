import 'dart:async';
import 'package:driver_durub/auth/login_screen.dart';
import 'package:driver_durub/firebase_options.dart';
import 'package:driver_durub/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';




  void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );


  User? user = FirebaseAuth.instance.currentUser;
  Widget initialRoute;

  if (user != null) {
    initialRoute = Homescreen();
  } else {
    initialRoute = SplashScreen();
  }

  runApp(MyApp(initialRoute: initialRoute));
  }

  class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Your App Title',
          theme: ThemeData.light(),
          initialRoute: '/',
          routes: {
            '/': (context) => initialRoute,
            '/login': (context) => LoginScreen(),
            '/home': (context) => Homescreen(),
          },
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

    @override
    void initState() {
      
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);


    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );


    _opacityAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );


    Timer(const Duration(seconds: 4), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Homescreen()),

        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
  _controller.dispose();
  super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Opacity(
                opacity: _opacityAnimation.value,
                child: Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 100.w, 
                      height: 100.w, 
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'), 
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          
              Positioned(
                bottom: 10.h, 
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Made By Zero one Technology',
                    style: TextStyle(
                      fontSize: 15.sp, 
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
