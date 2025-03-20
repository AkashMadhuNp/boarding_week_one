import 'package:flutter/material.dart';

class AppColors {
  // Basic Colors
  static const Color red = Color(0xFFFF0000);
  static const Color blue = Color(0xFF0000FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF808080);
  static const Color lightBlue =Color(0xFF1976D2);
  static const Color green = Colors.green;
  
  // Gradient Colors
  static const LinearGradient redToBlueGradient = LinearGradient(
    colors: [red, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //button background color

  static const LinearGradient buttonblue = LinearGradient(colors: [   
     Color(0xFF1976D2), 
      Color(0xFF64B5F6),
      ]);

  // Professional Blue-White Gradient
  static const LinearGradient blueWhiteGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
     
      Color(0xFF1976D2), // Professional deep blue
      Color(0xFF64B5F6), // Light blue
      Color(0xFFE3F2FD), // Very light blue/almost white
      Color(0xFFFFFFFF), // Pure white
    ],
    stops: [0.0, 0.4, 0.8, 1.0], // Controls the transition points
  );



  
}