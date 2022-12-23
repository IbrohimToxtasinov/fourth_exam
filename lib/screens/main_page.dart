import 'package:fifth_exam/screens/animations/animation_circular_bar.dart';
import 'package:fifth_exam/screens/dio/user_screen.dart';
import 'package:fifth_exam/screens/firebase/students/all_students_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const AllStudentsScreen(),
      const AllUsersScreen(),
      const AnimationCircularBar(),
    ];
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Firebase'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Dio'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Custom Paint'),
          ],
        ),
      ),
    );
  }
}
