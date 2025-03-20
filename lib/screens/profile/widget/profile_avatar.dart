import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bw_project/constants/colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String? profileImageUrl;
  final String? username;
  final String? email;

  const ProfileAvatar({
    Key? key,
    this.profileImageUrl,
    this.username,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: AppColors.lightBlue.withOpacity(0.5),
      backgroundImage: profileImageUrl != null 
        ? NetworkImage(profileImageUrl!) 
        : const AssetImage("assets/profile.jpg") as ImageProvider,
      child: profileImageUrl == null
        ? Text(
            _getInitials(username ?? email ?? ""),
            style: GoogleFonts.montserrat(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        : null,
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return "";
    
    List<String> nameParts = name.split(" ");
    if (nameParts.isEmpty) return "";
    
    if (nameParts.length == 1) {
      return nameParts[0][0].toUpperCase();
    }
    
    return nameParts[0][0].toUpperCase() + (nameParts.length > 1 ? nameParts[1][0].toUpperCase() : "");
  }
}