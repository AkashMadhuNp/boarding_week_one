import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/auth/signUp/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountText extends StatelessWidget {
  const AccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Create an Account ?",
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.lightBlue
          ),
          ),
    
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage(),));
            
          }, child: Text("Sign Up",style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.red
          ),))
        ],
      ),
    );
  }
}

