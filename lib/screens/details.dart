/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:student_manager/db/student.dart';
import 'package:student_manager/screens/edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails({Key? key}) : super(key: key);

  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  var noImage = Image.asset('assets/images/nopic.jpg');
  var profilePic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScreenEdit()));
            },
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ((GetAllStudents.finalImage != null) ||
                    (GetAllStudents.finalImage != 'error') ||
                    (GetAllStudents.finalImage != ''))
                ? Image.network(
                    GetAllStudents.finalImage,
                    loadingBuilder: (context, child, loadingProgress) =>
                        (loadingProgress == null)
                            ? child
                            : const CircularProgressIndicator(),
                    errorBuilder: (context, error, stackTrace) => noImage,
                  )
                : noImage,
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${GetAllStudents.name}',
                        style: GoogleFonts.marmelad(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Department: ${GetAllStudents.department}',
                        style: GoogleFonts.marmelad(fontSize: 20)),
                    Text('Roll No: ${GetAllStudents.rollNo}',
                        style: GoogleFonts.marmelad(fontSize: 20)),
                    SelectableText(
                        'Admission No: ${GetAllStudents.admissionNo}',
                        style: GoogleFonts.marmelad(fontSize: 20)),
                    SelectableText(
                      'Reg No: ${GetAllStudents.regNo}',
                      style: GoogleFonts.marmelad(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('DOB: ${GetAllStudents.dob}',
                        style: GoogleFonts.syne(fontSize: 18)),
                    Text('Blood: ${GetAllStudents.bloodGroup}',
                        style: GoogleFonts.syne(fontSize: 18)),
                    Text('Year of Admission: ${GetAllStudents.yearOfAdmission}',
                        style: GoogleFonts.syne(fontSize: 18)),
                    Text('Category: ${GetAllStudents.category}',
                        style: GoogleFonts.syne(fontSize: 18)),
                    Text('Student Phone: ${GetAllStudents.studentPhone}',
                        style: GoogleFonts.syne(fontSize: 18)),
                    Text('Parent Name: ${GetAllStudents.parentName}',
                        style: GoogleFonts.syne(fontSize: 18)),
                    Text('Parent Phone: ${GetAllStudents.parentPhone}',
                        style: GoogleFonts.syne(fontSize: 18)),
                    SelectableText('Address: ${GetAllStudents.address}',
                        style: GoogleFonts.koHo(fontSize: 18)),
                    Text('Remarks: ${GetAllStudents.remark}',
                        style: GoogleFonts.syne(fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: FloatingActionButton(
                            heroTag: const Text('phone'),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                            leading: const Icon(Icons.call),
                                            title: const Text('Student'),
                                            onTap: () => launch(
                                                'tel:+91${GetAllStudents.studentPhone}')),
                                        ListTile(
                                            leading:
                                                const Icon(Icons.call_outlined),
                                            title: const Text('Parent'),
                                            onTap: () => launch(
                                                'tel:+91${GetAllStudents.parentPhone}')),
                                        FloatingActionButton.small(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(Icons.arrow_back))
                                      ],
                                    );
                                  });
                            },
                            child: const Icon(Icons.call),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: FloatingActionButton(
                            heroTag: const Text('sms'),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                            leading: const Icon(Icons.message),
                                            title: const Text('Student'),
                                            onTap: () async {
                                              try {
                                                var uri =
                                                    'sms:+91${GetAllStudents.studentPhone}?body=hello%20there';
                                                await launch(uri);
                                              } catch (e) {
                                                // iOS
                                                var uri =
                                                    'sms:+91${GetAllStudents.studentPhone}&body=hello%20there';
                                                await launch(uri);
                                              }
                                            }),
                                        ListTile(
                                            leading: const Icon(
                                                Icons.message_outlined),
                                            title: const Text('Parent'),
                                            onTap: () async {
                                              try {
                                                var uri =
                                                    'sms:+91${GetAllStudents.parentPhone}?body=hello%20there';
                                                await launch(uri);
                                              } catch (e) {
                                                // iOS
                                                var uri =
                                                    'sms:+91${GetAllStudents.parentPhone}&body=hello%20there';
                                                await launch(uri);
                                              }
                                            }),
                                        FloatingActionButton.small(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(Icons.arrow_back))
                                      ],
                                    );
                                  });
                            },
                            child: const Icon(Icons.message),
                          ),
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
