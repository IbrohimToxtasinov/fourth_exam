import 'package:fifth_exam/data/models/students/students_model.dart';
import 'package:fifth_exam/screens/firebase/students/add_student_screen.dart';
import 'package:fifth_exam/screens/firebase/students/update_student_screen.dart';
import 'package:fifth_exam/view_models/students_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllStudentsScreen extends StatefulWidget {
  const AllStudentsScreen({Key? key}) : super(key: key);

  @override
  State<AllStudentsScreen> createState() => _AllStudentsScreenState();
}

class _AllStudentsScreenState extends State<AllStudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddStudentsScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Consumer<StudentsViewModel>(
        builder: ((context, categoryViewModel, child) {
          return ListView(
            children: List.generate(categoryViewModel.students.length, (index) {
              StudentModel students = categoryViewModel.students[index];
              return ListTile(
                title: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(students.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 20),
                    Text(students.studentName),
                  ],
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateStudentsScreen(
                                  studentModel: students,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            Provider.of<StudentsViewModel>(context,
                                    listen: false)
                                .deleteStudent(students.studentId);

                            print("DELETING ID:${students.studentId}");
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
