/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

import 'package:student_manager/db/filter_check.dart';
import 'package:student_manager/db/student.dart';
import 'package:student_manager/screens/details.dart';
import 'package:student_manager/widgets/loading.dart';
import 'package:flutter/material.dart';

class ScreenFiltered extends StatefulWidget {
  const ScreenFiltered({Key? key}) : super(key: key);

  @override
  State<ScreenFiltered> createState() => _ScreenFilteredState();
}

class _ScreenFilteredState extends State<ScreenFiltered> {
  static const _filedSnackBar = SnackBar(
    content: Text('Network filed!'),
    backgroundColor: Color.fromARGB(255, 199, 31, 31),
  );
  var noImage = Image.asset(
    'assets/images/nopic.jpg',
    fit: BoxFit.cover,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Check.f_filter == ''
            ? const Text('Filtered')
            : Text('${Check.f_filter}'),
      ),
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                var std = Check.filtered_list;
                var stdId = std[index]['id'];
                var stdName = std[index]['name'];
                var stdDept = std[index]['department'];
                var stdImg = std[index]['image'];
                String finalImage;
                try {
                  var imgSplitted = stdImg.split('/');
                  finalImage = 'https://drive.google.com/u/0/uc?id=' +
                      imgSplitted[5] +
                      '&export=download';
                  Image.network(finalImage);
                } catch (e) {
                  finalImage = '0';
                }
                return InkWell(
                    onTap: () async {
                      try {
                        loadScreen(context);
                        await GetAllStudents().getStudents(stdId);
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenDetails()));
                      } catch (e) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(_filedSnackBar);
                      }
                    },
                    child: ListTile(
                      title: Text(stdName),
                      subtitle: Text(stdDept),
                      leading: finalImage != '0' ? CircleAvatar(
                        backgroundImage: NetworkImage(finalImage),
                      ): const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/nopic.jpg'),
                      )
                    )
                    );
              },
              separatorBuilder: (context, int index) => const Divider(),
              itemCount: Check.filtered_list.length)),
    );
  }
}
