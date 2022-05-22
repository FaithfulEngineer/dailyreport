import '/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddBookModel extends ChangeNotifier {
  final Book book;

  String? reportdate = DateFormat.yMMMEd('ja').format(DateTime.now());
  String? dairy;
  String? type;
  String? email;
  String? contents;
  DateTime? reportdated;

  AddBookModel(this.book) {
    type = book.type;
    contents = book.contets;
  }

  var typeController = TextEditingController();

  Future addBook() async {
    if (reportdated == null || reportdated == "") {
      throw '日付が入力されていません';
    }

    if (dairy == null || dairy!.isEmpty) {
      throw '日誌が入力されていません';
    }

    if (type == null || type == "") {
      throw '種別（数字）が入力されていません';
    }

    if (email == 'NA' || email == "") {
      throw 'emailアドレスが設定されていません';
    }

    //重複チェックはすべきか、日付を変更できなくするとチェックは不要のはず

    // firestoreに追加
    await FirebaseFirestore.instance.collection('report').add({
      'date': reportdated,
      'type': type,
      'dairy': dairy,
      'email': email,
      'contents': contents,
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
