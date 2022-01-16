import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_data.dart';

class StorageProvider {
  Future<UserData?> getUserdata({
    required String uid,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (!documentSnapshot.exists) return null;

    Map<String, dynamic>? data = documentSnapshot.data();

    return UserData(
      uid: documentSnapshot.id,
      firstName: data!['firstName'],
      email: data['email'],
      lastName: data['lastName'],
      role: data['role'],
    );
  }
}
