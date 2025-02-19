import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // Singleton instance
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  static const String _keyUserToken = 'TOKEN';
  static const String _keyUserId = 'ID';
  static const String _keyUserEmail = 'EMAIL';
  static const String _keyUserName = 'NAME';
  static const String _keyUserMobile = 'MOBILE';
  static const String _keyUserAddress = 'ADDRESS';
  static const String _keyUserPhoto = 'PHOTO';

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save user data
  Future<void> saveUserData(
      String token,
      String id,
      String name,
      String email,
      String mobile,
      String address,
      String photo
      ) async {
    await _prefs?.setString(_keyUserToken, token);
    await _prefs?.setString(_keyUserId, id);
    await _prefs?.setString(_keyUserName, name);
    await _prefs?.setString(_keyUserEmail, email);
    await _prefs?.setString(_keyUserMobile, mobile);
    await _prefs?.setString(_keyUserAddress, address);
    await _prefs?.setString(_keyUserPhoto, photo);
  }

  // Update user data
  Future<void> updateUserData(
      String name,
      String email,
      String address,
      ) async {
    await _prefs?.setString(_keyUserName, name);
    await _prefs?.setString(_keyUserEmail, email);
    await _prefs?.setString(_keyUserAddress, address);
  }


  // Get user Token
  String? get userToken => _prefs?.getString(_keyUserToken);

  // Get user id
  String? get userId => _prefs?.getString(_keyUserId);

  // Get user name
  String? get userName => _prefs?.getString(_keyUserName);

  // Get user email
  String? get userEmail => _prefs?.getString(_keyUserEmail);

  // Get user mobile
  String? get userMobile => _prefs?.getString(_keyUserMobile);

  // Get user address
  String? get userAddress => _prefs?.getString(_keyUserAddress);

  // Get user photo
  String? get userPhoto => _prefs?.getString(_keyUserPhoto);


  // Clear user data (logout)
  Future<void> clearUserData() async {
    await _prefs?.remove(_keyUserToken);
    await _prefs?.remove(_keyUserId);
    await _prefs?.remove(_keyUserName);
    await _prefs?.remove(_keyUserEmail);
    await _prefs?.remove(_keyUserMobile);
    await _prefs?.remove(_keyUserAddress);
    await _prefs?.remove(_keyUserPhoto);
  }
}