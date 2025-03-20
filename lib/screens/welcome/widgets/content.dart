import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/welcome/widgets/fancy_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedTextKit(
          animatedTexts: [
            FadeAnimatedText(
              'Welcome',
              textStyle: GoogleFonts.montserrat(
                fontSize: 24,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(milliseconds: 2000),
            ),
          ],
          totalRepeatCount: 5,
          pause: const Duration(milliseconds: 1000),
        ),
        const SizedBox(height: 20),
        const FancyGradientText(text: "SECRET"),
        const SizedBox(height: 8),
        Text(
          "SNAPS",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}