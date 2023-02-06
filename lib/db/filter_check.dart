/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:student_manager/db/student.dart';

class Check {
  static var f_filter;
  static var filtered_list = [];
  checkFilter(filter) async {
    if (filter == 'bca') {
      f_filter = 'BCA';
    } else if (filter == 'bsccs') {
      f_filter = 'BSc CS';
    }
    filtered_list.clear();
    var list = GetAllStudents.allDetails;
    var list1 = await jsonDecode(list.toString());

    if (filter == 'bca') {
      for (var i = 0; i < list1.length; i++) {
        if (list1[i]['department'] == 'BCA') {
          filtered_list.add(list1[i]);
        }
      }
    } else if (filter == 'bsccs') {
      for (var i = 0; i < list1.length; i++) {
        if (list1[i]['department'] == 'BSc CS') {
          filtered_list.add(list1[i]);
        }
      }
    }
  }
}
