import 'role.dart';

class UserData {
  final String uid;
  final Role role;
  final String email;
  final String firstName;
  final String lastName;
  UserData({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });
}
