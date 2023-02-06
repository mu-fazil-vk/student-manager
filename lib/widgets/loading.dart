/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

loadScreen(context) async {
  const List<Color> _defaultColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  return showDialog(
    barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.lineScalePulseOutRapid,
              colors: _defaultColors,
              strokeWidth: 4.0,
              //backgroundColor: Colors.black,
            ),
          ),
        );
      });
}
