import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
 
  static const _keyIsLoggedIn = 'isLoggedIn';
  static const _keyUserId = 'userId';
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyProfileImage = 'profileImage';
 
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }
 
  static Future<void> saveLoginStatus(bool isLoggedIn) async {
    await _preferences.setBool(_keyIsLoggedIn, isLoggedIn);
  }
 
  static bool getLoginStatus() {
    return _preferences.getBool(_keyIsLoggedIn) ?? false;
  }
 
  static Future<void> saveUserData(User user, {String? username}) async {
    await _preferences.setString(_keyUserId, user.uid);
    


    if (username != null && username.isNotEmpty) {
      await _preferences.setString(_keyUsername, username);
    } else if (user.displayName != null && user.displayName!.isNotEmpty) {
      await _preferences.setString(_keyUsername, user.displayName!);
    } else if (user.email != null) {
      String defaultUsername = user.email!.split('@')[0];
      await _preferences.setString(_keyUsername, defaultUsername);
    }
    
       if (user.email != null) {
      await _preferences.setString(_keyEmail, user.email!);
    }
    
    
    if (user.photoURL != null) {
      await _preferences.setString(_keyProfileImage, user.photoURL!);
    }
  }

  
  static Future<void> setUsername(String username) async {
    await _preferences.setString(_keyUsername, username);
  }

  static Future<void> setEmail(String email) async {
    await _preferences.setString(_keyEmail, email);
  }

  static Future<void> setProfileImage(String url) async {
    await _preferences.setString(_keyProfileImage, url);
  }

  
  static String? getUserId() {
    return _preferences.getString(_keyUserId);
  }

  static String? getUsername() {
    return _preferences.getString(_keyUsername);
  }

  static String? getEmail() {
    return _preferences.getString(_keyEmail);
  }

  static String? getProfileImage() {
    return _preferences.getString(_keyProfileImage);
  }

  static Future<void> clearUserData() async {
    await _preferences.remove(_keyUserId);
    await _preferences.remove(_keyUsername);
    await _preferences.remove(_keyEmail);
    await _preferences.remove(_keyProfileImage);
    await _preferences.setBool(_keyIsLoggedIn, false);
  }
}