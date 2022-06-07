import '/domain/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IconListModel extends ChangeNotifier {
  List<Setting>? settings;
  String? email;
  List<int> types = [0];

  void iconfetchList(String email) async {
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

    var _types;
    _types = settings.map((e) => e.type);

    var _flg = 'n';

    for (int i = 1; i < 13; i++) {
      for (String _itypes in _types) {
        if (i == int.tryParse(_itypes)) {
          types.add(1);
          _flg = 'y';
          break;
        }
      }
      if (_flg != 'y') {
        types.add(0);
      } else {
        _flg = 'n';
      }
    }

    this.settings = settings;
    this.types = types;

    notifyListeners();
  }

  int GetTypes(int n) {
    return types[n];
  }
}
