import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_abans/providers/user_provider.dart';
import 'package:my_abans/screens/auth_screen.dart';
import 'package:my_abans/utils/custom_colors.dart';
import 'package:my_abans/utils/navigation_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      Timer(Duration(seconds: 3), () {
        NavigationManager.goWithReplace(context, AuthScreen());
      });
    } else {
      Timer(Duration(seconds: 1), () {
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).fetchUserData(context);
      });
    }
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
