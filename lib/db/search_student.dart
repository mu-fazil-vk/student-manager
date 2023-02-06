// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:student_manager/db/student.dart';

class StdSearch {
  static var lists;
  searcher() async {
    var list = GetAllStudents.allDetails;
    var list1 = await jsonDecode(list.toString());
    lists = list1;
  }
}
