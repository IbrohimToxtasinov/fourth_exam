import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifth_exam/data/repositories/students_repository.dart';
import 'package:fifth_exam/screens/main_page.dart';
import 'package:fifth_exam/view_models/students_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var fireStore = FirebaseFirestore.instance;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentsViewModel(
            studentRepository: StudentRepository(
              firebaseFirestore: fireStore,
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}