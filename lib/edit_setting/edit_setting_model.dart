import '/domain/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditSettingModel extends ChangeNotifier {
  final Setting setting;
  EditSettingModel(this.setting) {
    typeController.text = setting.type;
    contentsController.text = setting.contents;
  }

  var typeController = TextEditingController();
  final contentsController = TextEditingController();

  String? type;
  String? contents;

  void setType(String type) {
    this.type = type;
    notifyListeners();
  }

  void setContents(String contents) {
    this.contents = contents;
    notifyListeners();
  }

  bool isUpdated() {
    return type != null || contents != null;
  }

  Future update() async {
    this.type = typeController.text;
    this.contents = contentsController.text;

    // firestoreに追加
    await FirebaseFirestore.instance
        .collection('setting')
        .doc(setting.id)
        .update({
      'type': type,
      'contents': contents,
    });
  }
}
