import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bw_project/constants/colors.dart';

class ProfileInfoContainer extends StatelessWidget {
  final String label;

  const ProfileInfoContainer({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.blue,
            width: 2
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}