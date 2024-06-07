// In a separate file (e.g., user_data.dart)

import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = StateProvider<UserData>(
  (ref) => UserData(username: '', email: '', isVip: false),
);

class UserData {
  final String username;
  final String email;
  final bool isVip;

  UserData({required this.username, required this.email, required this.isVip});

  UserData copyWith({
    String? username,
    String? email,
    bool? isVip,
  }) {
    return UserData(
      username: username ?? this.username,
      email: email ?? this.email,
      isVip: isVip ?? this.isVip,
    );
  }
}
