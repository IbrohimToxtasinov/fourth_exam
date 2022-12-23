import 'dart:async';
import 'package:fifth_exam/data/models/students/students_model.dart';
import 'package:fifth_exam/data/repositories/students_repository.dart';
import 'package:flutter/cupertino.dart';

class StudentsViewModel extends ChangeNotifier {
  final StudentRepository studentRepository;

  StudentsViewModel({required this.studentRepository}) {
    listenStudents();
  }

  late StreamSubscription subscription;

  List<StudentModel> students = [];

  listenStudents() async {
    subscription = studentRepository.getAllStudents().listen((allStudents) {
      students = allStudents;
      notifyListeners();
    })
      ..onError((er) {});
  }

  addStudent(StudentModel studentModel) =>
      studentRepository.addStudent(studentModel: studentModel);
  updateStudent(StudentModel studentModel) =>
      studentRepository.updateStudent(studentModel: studentModel);
  deleteStudent(String docId) => studentRepository.deleteStudent(docId: docId);

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
