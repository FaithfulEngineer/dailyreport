import '/domain/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String sun = '0';
String mon = '0';
String tue = '0';
String wed = '0';
String thu = '0';
String fri = '0';
String sta = '0';

class EditSettingModel extends ChangeNotifier {
  //final List<Setting>? setting;
  final Setting setting;

  EditSettingModel(this.setting) {
    typeController.text = setting.type;
    contentsController.text = setting.contents;
    weekController.text = setting.plan;
    sun = setting.plan[0];
    mon = setting.plan[1];
    tue = setting.plan[2];
    wed = setting.plan[3];
    thu = setting.plan[4];
    fri = setting.plan[5];
    sta = setting.plan[6];
  }

  var typeController = TextEditingController();
  final contentsController = TextEditingController();
  final weekController = TextEditingController();

  String? type;
  String? contents;
  String? plan;

  void setType(String type) {
    this.type = type;
    notifyListeners();
  }

  void setContents(String contents) {
    this.contents = contents;
    notifyListeners();
  }

  bool isUpdated() {
    return type != null || contents != null || plan != null;
  }

/*   void setplan(String plan) {
    this.plan = plan;

    print(plan);
    notifyListeners();
  } */

  Future update() async {
    this.type = typeController.text;
    this.contents = contentsController.text;
    this.plan = weekController.text;

    // firestoreに追加
    await FirebaseFirestore.instance
        .collection('setting')
        .doc(setting.id)
        .update({
      'type': type,
      'contents': contents,
      'plan': plan,
    });
  }

  void weeklyplan() {
    weekController.text = sun + mon + tue + wed + thu + fri + sta;
    this.plan = weekController.text;

    notifyListeners();
  }
}
