// main.dart
import 'package:flutter/material.dart';
import 'student.dart';
import 'list_student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ListStudent studentList = ListStudent();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentFormScreen(studentList: studentList),
    );
  }
}

class StudentFormScreen extends StatefulWidget {
  final ListStudent studentList;

  StudentFormScreen({required this.studentList});

  @override
  _StudentFormScreenState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void submitStudent() {
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;

    Student newStudent = Student(name: name, phoneNumber: phoneNumber);
    widget.studentList.addStudent(newStudent);

    // Clear text fields after submitting
    nameController.clear();
    phoneNumberController.clear();

    // Force rebuild to update the student list
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Info App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: submitStudent,
              child: Text('Submit'),
            ),
            SizedBox(height: 16),
            Text(
              'Student List:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.studentList.students.length,
                itemBuilder: (context, index) {
                  var student = widget.studentList.students[index];
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text(student.phoneNumber),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
