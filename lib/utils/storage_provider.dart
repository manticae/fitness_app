import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/role.dart';
import '../models/program_data.dart';
import '../models/user_data.dart';

class StorageProvider {
  Future<List<ProgramData>> getPrograms() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('programs').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allPrograms =
        querySnapshot.docs;

    List<ProgramData> programs = [];
    for (var program in allPrograms) {
      programs.add(
        ProgramData(
          description: program.data()['description'],
          title: program.data()['title'],
          uid: program.id,
          image: program.data()['image'],
        ),
      );
    }
    return programs;
  }

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
        role: getRolesFromString(data['role']));
  }
}
