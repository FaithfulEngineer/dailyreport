import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookModel extends ChangeNotifier {
  String? reportdate;
  String? dairy;
  String? type;
  String? email;
  DateTime reportdated = DateTime.now();

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

    //print('更新直前' + email!);

    // firestoreに追加
    await FirebaseFirestore.instance.collection('report').add({
      'date': reportdated,
      'type': type,
      'dairy': dairy,
      'email': email,
    });
  }

  void setType(String type) {
    this.type = type;
    notifyListeners();
  }
}


//日付型に変換
