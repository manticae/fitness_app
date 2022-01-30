import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/program_content.dart';
import '../models/exercise.dart';
import '../models/program_data.dart';

class ProgramsProvider {
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

  Future<List<Exercise>> getExercisesForProgramContent({
    required String programContentId,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('exercises')
        .where('programContent', isEqualTo: programContentId)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> exercisesSnapshot =
        querySnapshot.docs;

    List<Exercise> exercises = [];
    for (var exercise in exercisesSnapshot) {
      exercises.add(
        Exercise(
          title: exercise.data()['title'],
          uid: exercise.id,
          index: exercise.data()['index'],
          programContentId: exercise.data()['programContent'],
        ),
      );
    }
    // Sort based on index
    exercises.sort((a, b) => a.index.compareTo(b.index));
    return exercises;
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
}
