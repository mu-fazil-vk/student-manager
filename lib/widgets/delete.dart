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
import 'package:student_manager/widgets/loading.dart';
import 'package:flutter/material.dart';

const _deletedSnackBar = SnackBar(
    content: Text('Deleted Successfully'),
    backgroundColor: Color.fromARGB(255, 29, 161, 187));
const _dlFiledSnackBar = SnackBar(
    content: Text('Delete filed!'),
    backgroundColor: Color.fromARGB(255, 179, 31, 199));

Widget buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Delete'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Are you sure to delete?"),
      ],
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () async {
              try {
                loadScreen(context);
                await StudentApi.delete(GetAllStudents.id);
                ScaffoldMessenger.of(context).showSnackBar(_deletedSnackBar);
                await GetAllStudents().loadStudents();
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ScreenHome()));
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(_dlFiledSnackBar);
              }
            },
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    ],
  );
}
