import 'package:flutter/material.dart';
import 'package:my_abans/screens/auth_screen.dart';
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
    Future.delayed(Duration(seconds: 3), () {
      NavigationManager.goWithReplace(context, AuthScreen());
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
