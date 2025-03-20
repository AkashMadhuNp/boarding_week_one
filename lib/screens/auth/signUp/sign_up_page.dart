import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/auth/signUp/utils/firebase_error_handler.dart';
import 'package:bw_project/screens/auth/signUp/widget/sign_up_form.dart';
import 'package:bw_project/screens/auth/signUp/widget/sign_up_loading.dart';
import 'package:bw_project/screens/home/home.dart';
import 'package:bw_project/screens/auth/utils/sharedPreferences/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Initialize Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Initialize Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.blueWhiteGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SignUpForm(
                  formKey: _formKey,
                  usernameController: _usernameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  onSignUp: (context) => _signUp(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      SignUpLoadingOverlay.show(context);

      try {
        await FirebaseAuth.instance.setSettings(
          appVerificationDisabledForTesting: true, 
        );

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (userCredential.user != null) {
          String username = _usernameController.text.trim();
          
          await _firestore.collection('users').doc(userCredential.user!.uid).set({
            'username': username,
            'email': _emailController.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
          });

          await UserPreferences.init();
          await UserPreferences.saveLoginStatus(true);
          await UserPreferences.saveUserData(
            userCredential.user!, 
            username: username
          );

          SignUpLoadingOverlay.hide(context);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } on FirebaseAuthException catch (e) {
        //print("Firebase Auth Error: ${e.code} - ${e.message}");
        
        SignUpLoadingOverlay.hide(context);
        
        FirebaseErrorHandler.showErrorDialog(
          context,
          FirebaseErrorHandler.getErrorMessage(e),
        );
      } catch (e) {
        //print("General Error: $e");
        
        SignUpLoadingOverlay.hide(context);
        
        FirebaseErrorHandler.showErrorDialog(
          context,
          'An error occurred: $e',
        );
      }
    }
  }
}