import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/program_content.dart';
import '../models/role.dart';
import '../models/program_data.dart';
import '../models/user_data.dart';

class StorageProvider {
  Future<List<ProgramData>> getPublicPrograms() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('programs')
        .where('isPrivate', isEqualTo: false)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allPrograms =
        querySnapshot.docs;

    List<ProgramData> programs = [];
    for (var program in allPrograms) {
      programs.add(
        ProgramData(
          isPrivate: program.data()['isPrivate'],
          description: program.data()['description'],
          title: program.data()['title'],
          uid: program.id,
          image: program.data()['image'],
        ),
      );
    }
    return programs;
  }

  Future<List<ProgramData>> getUserPrograms({required String userId}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('programs')
        .where('isPrivate', isEqualTo: true)
        .where('userId', isEqualTo: userId)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allPrograms =
        querySnapshot.docs;

    List<ProgramData> programs = [];
    for (var program in allPrograms) {
      programs.add(
        ProgramData(
          description: program.data()['description'],
          isPrivate: program.data()['isPrivate'],
          title: program.data()['title'],
          uid: program.id,
          image: program.data()['image'],
        ),
      );
    }
    return programs;
  }

  Future<List<ProgramContent>> getProgramContent({
    required String programId,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('programContent')
        .where('program', isEqualTo: programId)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> programContentSnapshot =
        querySnapshot.docs;

    List<ProgramContent> programContent = [];
    for (var content in programContentSnapshot) {
      programContent.add(
        ProgramContent(
          title: content.data()['title'],
          uid: content.id,
          index: content.data()['index'],
          program: content.data()['program'],
        ),
      );
    }
    // Sort based on index
    programContent.sort((a, b) => a.index.compareTo(b.index));
    return programContent;
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
