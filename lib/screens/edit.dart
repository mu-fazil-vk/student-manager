/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

import 'package:student_manager/api/gsheets/student_api.dart';
import 'package:student_manager/db/student.dart';
import 'package:student_manager/screens/home.dart';
import 'package:student_manager/widgets/delete.dart';
import 'package:student_manager/widgets/loading.dart';
import 'package:flutter/material.dart';

class ScreenEdit extends StatefulWidget {
  const ScreenEdit({Key? key}) : super(key: key);

  @override
  State<ScreenEdit> createState() => _ScreenEditState();
}

class _ScreenEditState extends State<ScreenEdit> {
  final TextEditingController _nameController =
      TextEditingController(text: GetAllStudents.name);
  var _department = GetAllStudents.department.toString();
  final TextEditingController _admissionNoController =
      TextEditingController(text: GetAllStudents.admissionNo);
  final TextEditingController _rollNoController =
      TextEditingController(text: GetAllStudents.rollNo);
  final TextEditingController _regNoController =
      TextEditingController(text: GetAllStudents.regNo);
  final TextEditingController _dobController =
      TextEditingController(text: GetAllStudents.dob);
  final TextEditingController _bloodController =
      TextEditingController(text: GetAllStudents.bloodGroup);
  final TextEditingController _yoaController =
      TextEditingController(text: GetAllStudents.yearOfAdmission);
  final TextEditingController _categoryController =
      TextEditingController(text: GetAllStudents.category);
  final TextEditingController _addressController =
      TextEditingController(text: GetAllStudents.address);
  final TextEditingController _sPhoneController =
      TextEditingController(text: GetAllStudents.studentPhone);
  final TextEditingController _pNameController =
      TextEditingController(text: GetAllStudents.parentName);
  final TextEditingController _pPhoneController =
      TextEditingController(text: GetAllStudents.parentPhone);
  final TextEditingController _remarkController =
      TextEditingController(text: GetAllStudents.remark);
  final TextEditingController _imgController =
      TextEditingController(text: GetAllStudents.image);
  final _savedSnackBar = const SnackBar(
      content: Text('Edited Successfully'),
      backgroundColor: Color.fromARGB(255, 31, 137, 199));
  final _filedSnackBar = const SnackBar(
      content: Text('Network filed!'),
      backgroundColor: Color.fromARGB(255, 199, 31, 31));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          buildPopupDialog(context),
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () async {
                    var user = {
                      'name': _nameController.text,
                      'department': _department,
                      'admissionNo': _admissionNoController.text,
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
                      'image': _imgController.text
                    };
                    try {
                      loadScreen(context);
                      await StudentApi.update(GetAllStudents.id, user);
                      await GetAllStudents().getStudents(GetAllStudents.id);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(_savedSnackBar);
                      await GetAllStudents().loadStudents();
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenHome()));
                    } catch (e) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(_filedSnackBar);
                    }
                  },
                  icon: const Icon(Icons.check_outlined)),
            ],
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                            _department = value.toString();
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
                              _department = value.toString();
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
                  labelText: 'Reg No',
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
                  labelText: 'Year Of Admission',
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
                maxLines: 10,
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
                  labelText: 'Image',
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
