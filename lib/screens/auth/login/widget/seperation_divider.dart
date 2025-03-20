import 'package:bw_project/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeperationDivider extends StatelessWidget {
  const SeperationDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColors.lightBlue.withOpacity(0.5),
              thickness: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "OR",
              style: GoogleFonts.montserrat(
                color: AppColors.lightBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: AppColors.lightBlue.withOpacity(0.5),
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
