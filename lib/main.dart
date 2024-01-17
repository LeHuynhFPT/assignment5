import 'package:flutter/material.dart';
import 'student.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ListStudent studentList = ListStudent();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentFormScreen(studentList: studentList),
      debugShowCheckedModeBanner: false,
    );
  }
}
