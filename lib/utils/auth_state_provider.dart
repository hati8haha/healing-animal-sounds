import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StateProvider<AuthState>(
  (ref) => AuthState(UserData(username: '', email: ''), false),
);

class AuthState {
  UserData userData;
  bool isLoggedIn;

  AuthState(this.userData, this.isLoggedIn);

  onLoggedIn(String username, String email, String photoURL) {
    userData.updateUserData(username, email, photoURL);
    isLoggedIn = true;
  }

  AuthState copyWith({
    UserData? userData,
    bool? isLoggedIn,
  }) {
    return AuthState(
      userData ?? this.userData,
      isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class UserData {
  String username;
  String email;
  bool isVIP; // Assuming VIP refers to premium access
  String photoURL;

  UserData(
      {required this.username,
      required this.email,
      this.isVIP = false,
      this.photoURL = ''});

  updateUserData(username, email, photoURL) {
    this.username = username;
    this.email = email;
    this.photoURL = photoURL;
  }

  updateVIP(isVIP) {
    this.isVIP = isVIP;
  }

  UserData copyWith({
    String? username,
    String? email,
    bool? isVIP,
    String? photoURL,
  }) {
    return UserData(
      username: username ?? this.username,
      email: email ?? this.email,
      isVIP: isVIP ?? false,
      photoURL: photoURL ?? '',
    );
  }
}
