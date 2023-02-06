/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

// ignore_for_file: prefer_typing_uninitialized_variables, constant_identifier_names

import 'dart:convert';

import 'package:student_manager/db/filter_check.dart';
import 'package:student_manager/db/search_student.dart';
import 'package:student_manager/db/string_to_json.dart';
import 'package:student_manager/db/student.dart';
import 'package:student_manager/screens/add.dart';
import 'package:student_manager/screens/details.dart';
import 'package:student_manager/screens/filtered.dart';
import 'package:student_manager/screens/menu.dart';
import 'package:student_manager/widgets/delete.dart';
import 'package:student_manager/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  static const _filedSnackBar = SnackBar(
    content: Text('Network filed!'),
    backgroundColor: Color.fromARGB(255, 199, 31, 31),
  );
  var _filter = 'default';
  var noImage = Image.asset(
    'assets/images/nopic.jpg',
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScreenMenu()));
            }),
        title: const Text('Students'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  await StdSearch().searcher();
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                  );
                },
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddStudentScreen()));
                  },
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: () async {
                    _bottomSheet(context);
                  },
                  icon: const Icon(Icons.filter_alt))
            ],
          ),
        ],
      ),
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                var studentName = GetAllStudents.stdnts[index];
                var studentDepartment = GetAllStudents.branch[index];
                var _currentIndex = index;
                return InkWell(
                  child: ListTile(
                    title: Text((studentName)),
                    subtitle: Text((studentDepartment)),
                    leading: CircleAvatar(
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: ClipOval(
                        child: Image.network(
                          GetAllStudents.profilePic[index],
                          loadingBuilder: (context, child, loadingProgress) =>
                              (loadingProgress == null)
                                  ? child
                                  : const CircularProgressIndicator(),
                          errorBuilder: (context, error, stackTrace) => noImage,
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 100.0,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    try {
                      loadScreen(context);
                      List st = GetAllStudents.allDetails;
                      String jsonString = st[_currentIndex];
                      Map<String, dynamic> map = jsonDecode(jsonString);
                      StdntsJson stdntsJson = StdntsJson.fromJson(map);
                      var id = stdntsJson.idTemp;
                      await GetAllStudents().getStudents(id);
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenDetails()));
                    } catch (e) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(_filedSnackBar);
                    }
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          buildPopupDialog(context),
                    );
                  },
                );
              },
              separatorBuilder: (context, int index) => const Divider(),
              itemCount: GetAllStudents.finalCount)),
    );
  }

  Future _bottomSheet(context) {
    return showModalBottomSheet(
        context: (context),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: RadioListTile(
                        title: const Text('Default'),
                        value: 'default',
                        groupValue: _filter,
                        onChanged: (value) {
                          setState(() {
                            _filter = value.toString();
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Department',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                            title: const Text('BCA'),
                            value: 'bca',
                            groupValue: _filter,
                            onChanged: (value) {
                              setState(() {
                                _filter = value.toString();
                              });
                            }),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                            title: const Text('BSc CS'),
                            value: 'bsccs',
                            groupValue: _filter,
                            onChanged: (value) {
                              setState(() {
                                _filter = value.toString();
                              });
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: IconButton(
                          onPressed: () async {
                            if (_filter == 'default') {
                              Navigator.pop(context);
                            } else {
                              await Check().checkFilter(_filter);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenFiltered()));
                            }
                          },
                          icon: const Icon(Icons.done),
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        });
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        },
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        )
      ];

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = GetAllStudents.stdnts.where((String suggestion) {
      return suggestion.toLowerCase().startsWith(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () async {
            query = suggestions[index];
            const _snackBar = SnackBar(
              content: Text('Loading...'),
              backgroundColor: Color.fromARGB(255, 49, 189, 189),
            );
            const _filedSnackBar = SnackBar(
              content: Text('Loading Filed!'),
              backgroundColor: Color.fromARGB(255, 209, 37, 37),
            );
            try {
              loadScreen(context);
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
              await pickStudent(query);
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScreenDetails()));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(_filedSnackBar);
            }
            //showResults(context);
          },
        );
      },
      itemCount: suggestions.length,
    );
  }

  pickStudent(String name) async {
    for (var i in GetAllStudents.allDetails) {
      //to json
      String jsonString = i;
      Map<String, dynamic> map = jsonDecode(jsonString);
      StdntsJson stdntsJson = StdntsJson.fromJson(map);
      var id = stdntsJson.idTemp;
      var nameJson = stdntsJson.nameTemp;
      if (nameJson == name) {
        await GetAllStudents().getStudents(id); //get student details
      }
    }
  }
}
