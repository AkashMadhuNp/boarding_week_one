
import 'package:bw_project/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountText extends StatelessWidget {
  const CreateAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "Account",
            style: GoogleFonts.montserrat(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 50
            ),
          ),
          Positioned(
            top: 0,
            child: Text(
              "Create Your",
              style: GoogleFonts.montserrat(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          ),
        ],
      ),
    );
  }
}