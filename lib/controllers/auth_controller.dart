import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_abans/utils/custom_dialogs.dart';

class AuthController {
  Future<User?> createUserAccount({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password' && context.mounted) {
        CustomDialogs.showErrorSnackBar(
          context,
          'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use' && context.mounted) {
        CustomDialogs.showErrorSnackBar(
          context,
          'The account already exists for that email.',
        );
      }
    } catch (e) {
      return null;
      //handle
    }
    return null;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
