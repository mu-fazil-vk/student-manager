/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

import 'package:student_manager/db/filter_check.dart';
import 'package:student_manager/screens/about.dart';
import 'package:student_manager/screens/filtered.dart';
import 'package:student_manager/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenMenu extends StatelessWidget {
  const ScreenMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _filedSnackBar = SnackBar(
      content: Text('Network filed!'),
      backgroundColor: Color.fromARGB(255, 199, 31, 31),
    );
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Department',
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 48,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScreenHome()));
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(_filedSnackBar);
                        }
                      },
                      child: const Text('ALL')),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await Check().checkFilter('bca');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ScreenFiltered()));
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(_filedSnackBar);
                        }
                      },
                      child: const Text('BCA')),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await Check().checkFilter('bsccs');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ScreenFiltered()));
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(_filedSnackBar);
                        }
                      },
                      child: const Text('Bsc CS')),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: FloatingActionButton.small(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      foregroundColor: const Color.fromARGB(255, 255, 0, 0),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenAbout()));
                      },
                      child: const Icon(Icons.info)),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
