/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:convert';
import 'package:student_manager/api/gsheets/student_api.dart';
import 'package:student_manager/db/string_to_json.dart';
import 'package:flutter/material.dart';

class StudentFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String department = 'department';
  static const String admissionNo = 'admissionNo';
  static const String rollNo = 'rollNo';
  static const String regNo = 'registerNo';
  static const String dob = 'dob';
  static const String bloodGroup = 'bloodGroup';
  static const String yearOfAdmission = 'yearOfAdmission';
  static const String category = 'category';
  static const String address = 'address';
  static const String studentPhone = 'studentPhone';
  static const String parentName = 'parentName';
  static const String parentPhone = 'parentPhone';
  static const String remark = 'remark';
  static const String image = 'image';

  static List<String> getFields() => [
        id,
        name,
        department,
        admissionNo,
        rollNo,
        regNo,
        dob,
        bloodGroup,
        yearOfAdmission,
        category,
        address,
        studentPhone,
        parentName,
        parentPhone,
        remark,
        image
      ];
}

class Student {
  final int? id;
  final String name;
  final String department;
  final String admissionNo;
  final String rollNo;
  final String regNo;
  final String dob;
  final String bloodGroup;
  final String yearOfAdmission;
  final String category;
  final String address;
  final String studentPhone;
  final String parentName;
  final String parentPhone;
  final String remark;
  final String image;

  const Student({
    this.id,
    required this.name,
    required this.department,
    required this.admissionNo,
    required this.rollNo,
    required this.regNo,
    required this.dob,
    required this.bloodGroup,
    required this.yearOfAdmission,
    required this.category,
    required this.address,
    required this.studentPhone,
    required this.parentName,
    required this.parentPhone,
    required this.remark,
    required this.image,
  });

  static Student fromJson(Map<String, dynamic> json) => Student(
        id: jsonDecode(json[StudentFields.id]),
        name: json[StudentFields.name],
        department: json[StudentFields.department],
        admissionNo: json[StudentFields.admissionNo],
        rollNo: json[StudentFields.rollNo],
        regNo: json[StudentFields.regNo],
        dob: json[StudentFields.dob],
        bloodGroup: json[StudentFields.bloodGroup],
        yearOfAdmission: json[StudentFields.yearOfAdmission],
        category: json[StudentFields.category],
        address: json[StudentFields.address],
        studentPhone: json[StudentFields.studentPhone],
        parentName: json[StudentFields.parentName],
        parentPhone: json[StudentFields.parentPhone],
        remark: json[StudentFields.remark],
        image: json[StudentFields.image],
      );
}

class GetAllStudents {
  static int finalLength = 0;
  static int finalCount = 0;
  static var finalProfile;
  static var stdnts = <String>[];
  static var branch = <String>[];
  static var profilePic = <String>[];

  static List allDetails = <String>[];

  Future loadStudents() async {
    int length = await StudentApi.getRowCount();
    finalLength = int.parse(length.toString());
    var lastRowCount = await StudentApi.getLastRow();
    finalCount = int.parse(lastRowCount.toString());

    stdnts.clear();
    branch.clear();
    allDetails.clear();
    profilePic.clear();
    var student;
    for (var i = 0; i <= finalLength; i++) {
      student = await StudentApi.getById(i);
      if (student == null) {
        continue;
      } else {
        var img = student!.image;
        try {
          var imgSplitted = img.split('/');
          finalProfile = 'https://drive.google.com/u/0/uc?id=' +
              imgSplitted[5] +
              '&export=download';
        } catch (e) {
          finalProfile = 'https://telegra.ph/file/70afb0c2deea0aed5c74f.jpg';
        }

        stdnts.add(student.name);
        branch.add(student.department);
        profilePic.add(finalProfile);

        var idTemp = student.id;
        var nameTemp = student.name;
        var departmentTemp = student.department;
        var admissionNoTemp = student.admissionNo;
        var rollNoTemp = student.rollNo;
        var regNoTemp = student.regNo;
        var dobTemp = student.dob;
        var bloodGroupTemp = student.bloodGroup;
        var yearOfAdmissionTemp = student.yearOfAdmission;
        var categoryTemp = student.category;
        var addressTemp = student.address;
        var studentPhoneTemp = student.studentPhone;
        var parentNameTemp = student.parentName;
        var parentPhoneTemp = student.parentPhone;
        var remarkTemp = student.remark;
        var imageTemp = student.image;

        StdntsJson stdntsJson = StdntsJson(
            idTemp,
            nameTemp,
            departmentTemp,
            admissionNoTemp,
            rollNoTemp,
            regNoTemp,
            dobTemp,
            bloodGroupTemp,
            yearOfAdmissionTemp,
            categoryTemp,
            addressTemp,
            studentPhoneTemp,
            parentNameTemp,
            parentPhoneTemp,
            remarkTemp,
            imageTemp);
        Map<String, dynamic> map = stdntsJson.toJson();
        String rawJson = jsonEncode(map);

        allDetails.add(rawJson);
      }
    }
  }

  static var name;
  static var id;
  static var department;
  static var admissionNo;
  static var rollNo;
  static var regNo;
  static var dob;
  static var bloodGroup;
  static var yearOfAdmission;
  static var category;
  static var address;
  static var studentPhone;
  static var parentName;
  static var parentPhone;
  static var remark;
  static var image;
  static var finalImage;

  Future getStudents(index) async {
    var student = await StudentApi.getById(index);
    id = student!.id;
    name = student.name;
    department = student.department;
    admissionNo = student.admissionNo;
    rollNo = student.rollNo;
    regNo = student.regNo;
    dob = student.dob;
    bloodGroup = student.bloodGroup;
    yearOfAdmission = student.yearOfAdmission;
    category = student.category;
    address = student.address;
    studentPhone = student.studentPhone;
    parentName = student.parentName;
    parentPhone = student.parentPhone;
    remark = student.remark;
    image = student.image;
    try {
      var imgSplitted = image.split('/');
      finalImage = 'https://drive.google.com/u/0/uc?id=' +
          imgSplitted[5] +
          '&export=download';
      Image.network(finalImage);
    } catch (e) {
      finalImage = 'https://telegra.ph/file/70afb0c2deea0aed5c74f.jpg';
    }
  }
}
