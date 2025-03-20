import 'package:bloc/bloc.dart';
import 'package:bw_project/screens/profile/bloc/profile_event.dart';
import 'package:bw_project/screens/profile/bloc/profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bw_project/screens/auth/login/login_screen.dart';
import 'package:bw_project/screens/auth/utils/sharedPreferences/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bw_project/constants/colors.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onLoadProfile(LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      final User? user = _auth.currentUser;
      String? email;
      String? username;
      String? profileImageUrl;
      
      if (user != null) {
        email = user.email;
        
        username = user.displayName;
        if (username == null || username.isEmpty) {
          username = await UserPreferences.getUsername();
        }
        profileImageUrl = user.photoURL;
      } else {
        email = await UserPreferences.getEmail();
        username = await UserPreferences.getUsername();
        profileImageUrl = await UserPreferences.getProfileImage();
      }

      emit(ProfileLoaded(
        username: username,
        email: email,
        profileImageUrl: profileImageUrl,
      ));
    } catch (e) {
      emit(ProfileError("Error loading profile: $e"));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<ProfileState> emit) async {
    bool? confirmSignOut = await _showSignOutConfirmationDialog(event.context);
    if (confirmSignOut != true) return;

    emit(SigningOut());
    
    try {
      _showSnackBar(event.context, "Signing out...", isLoading: true);
      await _auth.signOut();
      await UserPreferences.clearUserData();
      
      emit(SignedOut());
      
      _showSnackBar(event.context, "Signed out successfully", isSuccess: true);
      
      Navigator.of(event.context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
        (Route<dynamic> route) => false, 
      );
    } catch (e) {
      emit(ProfileError("Error signing out: $e"));
      _showSnackBar(event.context, "Error signing out: $e", isError: true);
    }
  }

  Future<bool?> _showSignOutConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Sign Out',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.lightBlue,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: GoogleFonts.montserrat(
            color: AppColors.grey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: GoogleFonts.montserrat(
                color: AppColors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Sign Out',
              style: GoogleFonts.montserrat(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, {bool isLoading = false, bool isSuccess = false, bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (isLoading) ...[
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              ),
              const SizedBox(width: 15),
            ],
            Text(
              message,
              style: GoogleFonts.montserrat(
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: isSuccess 
            ? AppColors.green 
            : isError 
                ? AppColors.red
                : null,
        duration: Duration(seconds: isLoading ? 1 : isError ? 3 : 2),
      ),
    );
  }
}
