import 'package:bw_project/screens/auth/utils/sharedPreferences/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initAuth() async {
    await _auth.setSettings(
      appVerificationDisabledForTesting: true, 
    );
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    // Create user with email and password
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    if (userCredential.user != null) {
      // Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Save login status and user info
      await UserPreferences.init();
      await UserPreferences.saveLoginStatus(true);
      await UserPreferences.saveUserData(
        userCredential.user!,
        username: username.trim(),
      );
    }

    return userCredential;
  }

  // Sign in with email and password
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    // Sign in user with email and password
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    if (userCredential.user != null) {
      // Save login status and user info
      await UserPreferences.init();
      await UserPreferences.saveLoginStatus(true);
      await UserPreferences.saveUserData(userCredential.user!);
    }

    return userCredential;
  }

  // Sign in with Google
 

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await UserPreferences.saveLoginStatus(false);
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Password reset
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }
}