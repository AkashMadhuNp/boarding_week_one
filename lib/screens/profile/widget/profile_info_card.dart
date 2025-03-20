import 'package:bw_project/screens/profile/widget/profile_info_row.dart';
import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final VoidCallback onSignOutPressed;

  const ProfileInfoCard({
    Key? key,
    required this.onSignOutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const ProfileInfoRow(
                icon: Icons.person,
                text: "Account Information",
              ),
              const Divider(),
              const ProfileInfoRow(
                icon: Icons.settings,
                text: "Settings",
              ),
              const Divider(),
              const ProfileInfoRow(
                icon: Icons.help_outline,
                text: "Help & Support",
              ),
              const Divider(),
              InkWell(
                onTap: onSignOutPressed,
                child: const ProfileInfoRow(
                  icon: Icons.exit_to_app,
                  text: "Sign Out",
                  isSignOut: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}