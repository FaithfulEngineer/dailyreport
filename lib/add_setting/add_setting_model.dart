import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSettingModel extends ChangeNotifier {
  String? type;
  String? contents;

  var typeController = TextEditingController();

  Future addSetting() async {
    if (type == null || type == "") {
      throw '種別（数字）が入力されていません';
    }

    if (contents == null || contents == "") {
      throw '内容が入力されてません';
    }

    // firestoreに追加
    await FirebaseFirestore.instance.collection('setting').add({
      'type': type,
      'contents': contents,
    });
  }

  void setType(String type) {
    this.type = type;
    notifyListeners();
  }
}
