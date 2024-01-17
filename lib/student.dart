import 'package:flutter/material.dart';

class Student {
  String name;
  String phoneNumber;

  Student({required this.name, required this.phoneNumber});
}

class ListStudent {
  List<Student> students = [];

  bool isPhoneNumberExists(String phoneNumber) {
    return students.any((student) => student.phoneNumber == phoneNumber);
  }

  void addStudent(Student student) {
    students.add(student);
  }
}

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  StudentDetailScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${student.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Phone Number: ${student.phoneNumber}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
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
    String name = nameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();

    // Kiểm tra xem tên và số điện thoại có trống không
    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      // Kiểm tra xem số điện thoại đã tồn tại trong danh sách chưa
      bool isPhoneNumberExists = widget.studentList.isPhoneNumberExists(phoneNumber);

      if (phoneNumber.length == 10 && phoneNumber.startsWith('0') && !isPhoneNumberExists) {
        // Nếu số điện thoại không trùng và đúng định dạng, thêm vào danh sách
        Student newStudent = Student(name: name, phoneNumber: phoneNumber);

        widget.studentList.addStudent(newStudent);

        nameController.clear();
        phoneNumberController.clear();

        setState(() {});
      } else {
        // Hiển thị cảnh báo cho số điện thoại trùng hoặc sai định dạng
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(isPhoneNumberExists ? 'Số điện thoại đã tồn tại' : 'Sai định dạng số điện thoại'),
              content: Text(isPhoneNumberExists ? 'Vui lòng nhập số điện thoại khác.' : 'Vui lòng nhập đúng định dạng số điện thoại bắt đầu bằng số 0 và bao gồm 10 số.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Hiển thị cảnh báo cho trường thông tin bị trống
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thông tin không đầy đủ'),
            content: Text('Vui lòng nhập đầy đủ thông tin tên và số điện thoại.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
                    title: Text(student.name),// hiển thị tên sinh viên

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailScreen(student: student),
                        ),
                      );
                    },
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
