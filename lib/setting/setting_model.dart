import '/domain/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingListModel extends ChangeNotifier {
  List<Setting>? settings;

  void fetchSettingList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('setting').get();

    final List<Setting> settings =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final String contents = data['contents'];
      return Setting(id, type, contents);
    }).toList();

    this.settings = settings;
    notifyListeners();
  }

  Future delete(Setting setting) {
    return FirebaseFirestore.instance
        .collection('setting')
        .doc(setting.id)
        .delete();
  }
}
