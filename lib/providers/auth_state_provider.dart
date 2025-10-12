import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:my_abans/controllers/auth_controller.dart';

class AuthStateProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signupUser() async {
    if (_emailController.text.trim().length < 3) {
      Logger().e('Email is too short');
    } else if (_passwordController.text.trim().length < 6) {
      Logger().e('Password is too short');
    } else if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      Logger().e('Password and Confirm Password do not match');
    } else {
      final user = await AuthController().createUserAccount(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Logger().i('User Created');
    }
  }
}
