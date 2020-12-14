import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eat_n_go/Login_Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

void main() {
  // Make status bar transparent
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: 'assets/images/icon_no_title.png',
        splashIconSize: 400.0,
        duration: 2000,
        nextScreen: LoginScreen(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
      ),
    );
  }
}
