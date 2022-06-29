import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSettingModel extends ChangeNotifier {
  String? type;
  String? contents;
  String? email;
  String? style;
  String? unit;
  String? plan;

  var typeController = TextEditingController();

  Future addSetting() async {
    if (type == null || type == "") {
      throw 'アイコンが設定されていません';
    }

    if (contents == null || contents == "") {
      throw '内容が入力されてません';
    }

    if (email == 'NA' || email == "") {
      throw 'emailアドレスが設定されていません';
    }

    if (style == null || style == "") {
      throw 'データ型が入力されていません';
    }

    if (style == '2' && (unit == null || unit == '')) {
      throw 'データ型が数字の場合は単位を必ず入力してください';
    }

    if (plan == null || plan == '') {
      throw '実施日が入力されていません';
    }

    if (unit == null) this.unit = 'NA'; //

    // firestoreに追加
    await FirebaseFirestore.instance.collection('setting').add({
      'type': type,
      'contents': contents,
      'email': email,
      'style': style,
      'unit': unit,
      'plan': plan,
    });
  }

  void setStyle(String style) {
    this.style = style;
    notifyListeners();
  }

  void setType(String type) {
    this.type = type;
    notifyListeners();
  }

  void setplan(String _plan) {
    this.plan = _plan;
    notifyListeners();
  }

  String resetflg(String weeklyPlan) {
    return '0000000';
  }
}
