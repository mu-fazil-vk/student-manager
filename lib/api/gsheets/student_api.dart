/*
============Copyright===============
Author       : Muhammed Fazil v k
Created Date : 15/03/2022
Description  : Student Manager
====================================
*/

// ignore_for_file: non_constant_identifier_names

import 'package:student_manager/db/student.dart';
import 'package:gsheets/gsheets.dart';

class StudentApi {
  static const _credentials = "CREDENTIALS HERE";
  static const _spreadsheetId = 'SHEET ID';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final Spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(Spreadsheet, title: 'Database');

      final firstRow = StudentFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      // ignore: avoid_print
      print('init Error $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;
    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<Student?> getById(int id) async {
    if (_userSheet == null) return null;
    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Student.fromJson(json);
  }

  static Future<int?> getLastRow() async {
    if (_userSheet == null) return null;
    final lastRow = await _userSheet!.values.allRows();
    final lr = (lastRow.length);
    // ignore: unnecessary_null_comparison
    return lastRow == null ? 0 : (lr - 1);
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<bool> update(int id, Map<String, dynamic> user) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.map.insertRowByKey(id, user);
  }

  static Future<bool> delete(int id) async {
    if (_userSheet == null) return false;

    final index = await _userSheet!.values.rowIndexOf(id);
    if (index == -1) return false;
    return _userSheet!.deleteRow(index);
  }
}
