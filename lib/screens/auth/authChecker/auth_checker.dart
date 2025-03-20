import 'package:bw_project/screens/auth/utils/sharedPreferences/shared_pref.dart';
import 'package:bw_project/screens/home/home.dart';
import 'package:bw_project/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
  try {
    _isLoggedIn = UserPreferences.getLoginStatus(); 
  } catch (e) {
    debugPrint("Error checking login status: $e");
    _isLoggedIn = false;
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return _isLoggedIn ? const HomeScreen() : const WelcomeScreen();
  }
}