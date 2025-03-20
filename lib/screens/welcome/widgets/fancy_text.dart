import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FancyGradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  
  const FancyGradientText({
    Key? key,
    required this.text,
    this.fontSize = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Colors.white,       // Start with white
          Colors.grey,        // Transition to grey
          Colors.white,       // End with white (instead of black)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: Colors.white,  // Base color set to white
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(3, 3),
              blurRadius: 5,
            ),
            Shadow(
              color: Colors.white.withOpacity(0.3),
              offset: const Offset(-2, -2),
              blurRadius: 4,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}