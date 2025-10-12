import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/web.dart';
import 'package:my_abans/controllers/auth_controller.dart';
import 'package:my_abans/utils/custom_dialogs.dart';

class AuthStateProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signupUser(BuildContext context) async {
    if (_emailController.text.trim().length < 3) {
      CustomDialogs.showErrorSnackBar(context, 'Email is too short');
    } else if (_passwordController.text.trim().length < 6) {
      CustomDialogs.showErrorSnackBar(context, 'Password is too short');
    } else if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Password and Confirm Password do not match',
      );
    } else {
      EasyLoading.show();
      final user = await AuthController().createUserAccount(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );
      EasyLoading.dismiss();
      Logger().i('User Created');
    }
  }
}
