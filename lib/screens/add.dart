/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:student_manager/api/gsheets/student_api.dart';
import 'package:student_manager/db/student.dart';
import 'package:student_manager/screens/home.dart';
import 'package:student_manager/widgets/loading.dart';
import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController _nameController = TextEditingController();
  var _department;
  final TextEditingController _admissionNoController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _yoaController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _sPhoneController = TextEditingController();
  final TextEditingController _pNameController = TextEditingController();
  final TextEditingController _pPhoneController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              var _id = await StudentApi.getRowCount() + 1;
              final student = {
                'id': _id,
                'name': _nameController.text,
                'department': _department,
                'admissionNo': _department,
                'rollNo': _rollNoController.text,
                'registerNo': _regNoController.text,
                'dob': _dobController.text,
                'bloodGroup': _bloodController.text,
                'yearOfAdmission': _yoaController.text,
                'category': _categoryController.text,
                'address': _addressController.text,
                'studentPhone': _sPhoneController.text,
                'parentName': _pNameController.text,
                'parentPhone': _pPhoneController.text,
                'remark': _remarkController.text,
                'image': _imgController.text,
              };
              try {
                loadScreen(context);
                await StudentApi.insert([student]);
                const _snackBar = SnackBar(
                  content: Text('Student Added'),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                await GetAllStudents().loadStudents();
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ScreenHome()));
              } catch (e) {
                Navigator.pop(context);
                const _snackBar = SnackBar(
                  content: Text('Failed Adding Student'),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(_snackBar);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: RadioListTile(
                        title: const Text('BCA'),
                        value: 'BCA',
                        groupValue: _department,
                        onChanged: (value) {
                          setState(() {
                            _department = value;
                          });
                        }),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: RadioListTile(
                          title: const Text('BSc CS'),
                          value: 'BSc CS',
                          groupValue: _department,
                          onChanged: (value) {
                            setState(() {
                              _department = value;
                            });
                          }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _admissionNoController,
                decoration: const InputDecoration(
                  labelText: 'Admission No',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _rollNoController,
                decoration: const InputDecoration(
                  labelText: 'Roll No',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _regNoController,
                decoration: const InputDecoration(
                  labelText: 'Register No',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: 'DOB',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _bloodController,
                decoration: const InputDecoration(
                  labelText: 'Blood Group',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _yoaController,
                decoration: const InputDecoration(
                  labelText: 'Year of Admission',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _addressController,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _sPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Student Phone',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _pNameController,
                decoration: const InputDecoration(
                  labelText: 'Parent Name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _pPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Parent Phone',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _remarkController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Remark',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _imgController,
                decoration: const InputDecoration(
                  labelText: 'Google Drive Image url',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
