import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/welcome/widgets/button.dart';
import 'package:bw_project/screens/welcome/widgets/content.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.blueWhiteGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Expanded(
              child: Center(
                child: Content(),
              ),
            ),
            
            WelcomeButton(),
          ],
        ),
      ),
    );
  }
}

