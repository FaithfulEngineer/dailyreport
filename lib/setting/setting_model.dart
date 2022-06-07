import '/domain/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingListModel extends ChangeNotifier {
  List<Setting>? settings;
  String? email;

  void fetchSettingList(String email) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('setting')
        .where('email', isEqualTo: email)
        .get();

    final List<Setting> settings =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final String contents = data['contents'];
      final String email = data['email'];
      final String style = data['style'];
      final String unit = data['unit'];
      final String plan = data['plan'];

      return Setting(id, type, contents, email, style, unit, plan);
    }).toList();

    settings.sort((a, b) {
      int ret = a.type[0].compareTo(b.type[0]);
      if (ret != 0) return ret;
      return a.type[1].compareTo(b.type[1]);
    });

    this.settings = settings;
    notifyListeners();
  }

  bool today(DateTime _today, String _weekplan) {
    int _weekday;
    if (_today.weekday == 7)
      _weekday = 0;
    else
      _weekday = _today.weekday;

    if (_weekplan[_weekday] == '0')
      return false;
    else
      return true;
  }

  Future delete(Setting setting) async {
    //retの判定エラーだったらreturn
    final QuerySnapshot snapshot;
    snapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('email', isEqualTo: setting.email)
        .where('type', isEqualTo: setting.type)
        .get();
    //エラーだったらreturn

    //report コレクションは論理削除する
    snapshot.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection('report')
          .doc(element.id)
          .update(
        {
          'delflg': '1',
        },
      );
    });

    var ret;
    ret = FirebaseFirestore.instance
        .collection('setting')
        .doc(setting.id)
        .delete();
  }

  void setplan(String _plan) {}

  void setemail(String email) {
    this.email = email;
    notifyListeners();
  }
}
