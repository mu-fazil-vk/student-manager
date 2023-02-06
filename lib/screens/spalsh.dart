/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

import 'package:student_manager/db/student.dart';
import 'package:student_manager/screens/menu.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();

    _splashScreen();
  }

  static const _filedSnackBar = SnackBar(
    content: Text('Network filed!'),
    backgroundColor: Color.fromARGB(255, 199, 31, 31),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 150),
                Image.asset('assets/images/splash.png'),
                const SizedBox(height: 50),
                const Text(
                  "Version 1.0.0\nBy Fazil vk",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }

  _splashScreen() async {
    try {
      await GetAllStudents().loadStudents();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ScreenMenu()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(_filedSnackBar);
    }
  }
}
