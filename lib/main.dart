import 'package:bw_project/firebase_options.dart';
import 'package:bw_project/screens/auth/authChecker/auth_checker.dart';
import 'package:bw_project/screens/auth/utils/sharedPreferences/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await UserPreferences.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthChecker(),
      debugShowCheckedModeBanner: false,
    );
  }
}

