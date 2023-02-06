/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: AnimatedTextKit(
                        isRepeatingAnimation: true,
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                        repeatForever: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'This app is developed by:\n\t Muhammed Fazil v k',
                            speed: const Duration(milliseconds: 100),
                            textStyle: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TyperAnimatedText(
                            'You can also contact me at:\n\tInstagram: @fazil.v.k',
                            speed: const Duration(milliseconds: 100),
                            textStyle: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TyperAnimatedText(
                            'Its from BCA, Computer Science\nDepartment.',
                            speed: const Duration(milliseconds: 100),
                            textStyle: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
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
                      launch('https://instagram.com/fazil.v.k/');
                    },
                    child: const FaIcon(FontAwesomeIcons.instagram)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
