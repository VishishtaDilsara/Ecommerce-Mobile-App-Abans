import 'package:flutter/material.dart';
import 'package:my_abans/components/custom_button.dart';
import 'package:my_abans/components/custom_text_field.dart';
import 'package:my_abans/providers/auth_state_provider.dart';
import 'package:my_abans/screens/home_page.dart';
import 'package:my_abans/utils/navigation_manager.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String authScreenType = 'signup'; // signup | signin | forgot

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthStateProvider>(
        builder: (context, authProvider, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/text_logo.png', height: 70),
                    SizedBox(height: 10),
                    Text(
                      authScreenType == 'signup'
                          ? 'Create New Account'
                          : authScreenType == 'signin'
                          ? 'Sign In'
                          : 'Forgot Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    Text(
                      authScreenType != 'forgot'
                          ? 'Connect with your User Account'
                          : 'Insert Your Email for reset Password',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      controller: authProvider.emailController,
                      label: 'Email Address',
                    ),
                    if (authScreenType != 'forgot')
                      CustomTextField(
                        controller: authProvider.passwordController,
                        label: 'Password',
                        isPassword: true,
                      ),
                    if (authScreenType == 'signup')
                      CustomTextField(
                        controller: authProvider.confirmPasswordController,
                        label: 'Confirm Password',
                        isPassword: true,
                      ),
                    SizedBox(height: 16),
                    if (authScreenType == 'signin')
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              authScreenType = 'forgot';
                            });
                          },
                          child: Text('Forgot Password'),
                        ),
                      ),

                    CustomButton(
                      text: authScreenType == 'signup'
                          ? 'Create New Account'
                          : authScreenType == 'signin'
                          ? 'Sign In'
                          : 'Send Password reset Email',
                      onTap: () {
                        setState(() {
                          if (authScreenType == 'signup') {
                            authProvider.signupUser(context);
                          } else if (authScreenType == 'signin') {
                            //signin
                          } else {
                            //forgot
                          }
                        });
                      },
                    ),
                    if (authScreenType != 'forgot')
                      Center(
                        child: Text(
                          authScreenType == 'signin'
                              ? "Didn't Have an Account"
                              : 'Already have an account?',
                        ),
                      ),
                    CustomButton(
                      text: authScreenType == 'signin'
                          ? 'Create New Account'
                          : 'Sign In',
                      isOutlinedButton: true,
                      onTap: () {
                        setState(() {
                          if (authScreenType == 'signin') {
                            authScreenType = 'signup';
                          } else {
                            authScreenType = 'signin';
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
