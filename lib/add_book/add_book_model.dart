import '/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddBookModel extends ChangeNotifier {
  final Book book;

  String? reportdate;
  String? dairy;
  String? type;
  String? email;
  String? contents;
  String? style;
  String? unit;
  DateTime? reportdated;

  AddBookModel(this.book) {
    reportdated = book.reoportdated;
    type = book.type;
    contents = book.contets;
    style = book.style;
    unit = book.unit;
  }

  var typeController = TextEditingController();

  Future addBook() async {
    if (reportdated == null || reportdated == "") {
      throw '日付が入力されていません';
    }

    if (dairy == null || dairy!.isEmpty) {
      throw '日誌（本文）が入力されていません';
    }

    if (type == null || type == "") {
      throw 'アイコンが設定されていません';
    }

    if (style == null || style == "") {
      throw 'データ型が入力されていません';
    }
    if (style == '2' && (unit == null || unit == '')) {
      throw 'データ型が数字の場合は単位を必ず入力してください';
    }

    if (email == 'NA' || email == "") {
      throw 'emailアドレスが設定されていません';
    }

    // firestoreに追加
    await FirebaseFirestore.instance.collection('report').add({
      'date': reportdated,
      'type': type,
      'dairy': dairy,
      'email': email,
      'contents': contents,
      'style': style,
      'unit': unit,
      'delflg': '0',
    });
  }

  void setDate(DateTime date) {
    this.reportdated = date;
    notifyListeners();
  }

  void setType(String type) {
    this.type = type;
    notifyListeners();
  }
}
