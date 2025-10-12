import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_abans/screens/auth_screen.dart';
import 'package:my_abans/screens/home_page.dart';
import 'package:my_abans/utils/custom_colors.dart';
import 'package:my_abans/utils/navigation_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          NavigationManager.goTo(context, AuthScreen());
        } else {
          NavigationManager.goTo(context, HomePage());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Center(
        child: Image.asset('assets/images/abansLogo.jpeg', width: 300),
      ),
    );
  }
}
