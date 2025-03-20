import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/auth/login/utils/firebase_login_auth_error.dart';
import 'package:bw_project/screens/auth/login/widget/login_form.dart';
import 'package:bw_project/screens/auth/login/widget/login_loading_overlay.dart';
import 'package:bw_project/screens/home/home.dart';
import 'package:bw_project/screens/auth/utils/sharedPreferences/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Initialize Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.blueWhiteGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: LoginForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onLogin: (context) => _signInWithEmailAndPassword(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      LoginLoadingOverlay.show(context);

      try {
        await UserPreferences.init();
        
        final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
        );

        if (userCredential.user != null) {
          // Save login status and user info
          await UserPreferences.saveLoginStatus(true);
          await UserPreferences.saveUserData(userCredential.user!);

          LoginLoadingOverlay.hide(context);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
        }
      } on FirebaseAuthException catch (e) {
        print("Firebase Auth Error: ${e.code} - ${e.message}");
        
        LoginLoadingOverlay.hide(context);
        
        FirebaseAuthErrorHandler.showErrorDialog(
          context,
          FirebaseAuthErrorHandler.getErrorMessage(e),
        );
      } catch (e) {
        print("General Error: $e");
        
        LoginLoadingOverlay.hide(context);
        
        FirebaseAuthErrorHandler.showErrorDialog(
          context,
          'An error occurred: $e',
        );
      }
    }
  }
}