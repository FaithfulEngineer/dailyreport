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
      return Setting(id, type, contents, email);
    }).toList();

    settings.sort((a, b) {
      return a.type[0].compareTo(b.type[0]);
    });

    this.settings = settings;
    notifyListeners();
  }

  Future delete(Setting setting) {
    return FirebaseFirestore.instance
        .collection('setting')
        .doc(setting.id)
        .delete();
  }

  void setemail(String email) {
    this.email = email;
    notifyListeners();
  }
}
