import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bw_project/constants/colors.dart';

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSignOut;

  const ProfileInfoRow({
    Key? key,
    required this.icon,
    required this.text,
    this.isSignOut = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSignOut ? AppColors.red : AppColors.lightBlue,
            size: 24,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSignOut ? AppColors.red : AppColors.grey,
            ),
          ),
          const Spacer(),
          if (!isSignOut)
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
        ],
      ),
    );
  }
}