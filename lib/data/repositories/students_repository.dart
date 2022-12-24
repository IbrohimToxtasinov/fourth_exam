import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifth_exam/data/models/students/students_model.dart';
import 'package:fifth_exam/utils/my_utils.dart';

class StudentRepository {
  final FirebaseFirestore _firestore;

  StudentRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addStudent({required StudentModel studentModel}) async {
    try {
      var newStudent =
          await _firestore.collection("students").add(studentModel.toJson());
      await _firestore.collection("students").doc(newStudent.id).update({
        "studentId": newStudent.id,
      });
      MyUtils.getMyToast(message: "Talaba muvaffaqiyatli qo'shiladi!");
    } on FirebaseException catch (error) {
      MyUtils.getMyToast(message: error.message.toString());
    }
  }

  Future<void> deleteStudent({required String docId}) async {
    try {
      await _firestore.collection("students").doc(docId).delete();
      MyUtils.getMyToast(message: "Talaba muvaffaqiyatli o'chirildi!");
    } on FirebaseException catch (error) {
      MyUtils.getMyToast(message: error.message.toString());
    }
  }

  Future<void> updateStudent({required StudentModel studentModel}) async {
    try {
      await _firestore
          .collection("students")
          .doc(studentModel.studentId)
          .update(studentModel.toJson());

      MyUtils.getMyToast(message: "Talaba ma'lumoti muvaffaqiyatli yangilandi!");
    } on FirebaseException catch (error) {
      MyUtils.getMyToast(message: error.message.toString());
    }
  }

  Stream<List<StudentModel>> getAllStudents() =>
      _firestore.collection("students").snapshots().map(
            (event1) => event1.docs
                .map((doc) => StudentModel.fromJson(doc.data()))
                .toList(),
          );

}