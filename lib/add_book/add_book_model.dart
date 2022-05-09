import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String? reportdate;
  String? dairy;
  DateTime reportdated = DateTime.now();

  Future addBook() async {
    if (reportdated == null || reportdated == "") {
      throw '日付が入力されていません';
    }

    if (dairy == null || dairy!.isEmpty) {
      throw '日誌が入力されていません';
    }

    // firestoreに追加
    await FirebaseFirestore.instance.collection('report').add({
      'date': reportdated,
      'dairy': dairy,
    });
  }
}

//日付型に変換
