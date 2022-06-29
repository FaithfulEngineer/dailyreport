import '/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBookModel extends ChangeNotifier {
  final Book book;
  EditBookModel(this.book) {
    dateController.text = book.reportdate;
    dairyController.text = book.diary;

    setstyle();
  }
  var dateController = TextEditingController();
  final dairyController = TextEditingController();
  final styleController = TextEditingController();
  final unitController = TextEditingController();

  DateTime? date;
  String? dairy;
  void setstyle() {
    switch (styleController.text) {
      case '1':
        styleController.text = '日誌型';
        break;
      case '2':
        styleController.text = '数値型';
        break;
      case '3':
        styleController.text = '実施/未実施型';
        break;

      case '4':
        styleController.text = '5段階型';
        break;
      default:
        break;
    }
  }

  void setDate(DateTime date) {
    this.date = date;
    notifyListeners();
  }

  void setDairy(String dairy) {
    this.dairy = dairy;
    notifyListeners();
  }

  bool isUpdated() {
    return date != null || dairy != null;
  }

  Future update(DateTime date, String style) async {
    dairy = dairyController.text;
    if (style == '2') {
      if (dairy != null || dairy!.isEmpty) {
        if (int.tryParse(dairy!) == null) {
          throw '数字が入力されていません';
        }
      }
    }

    // firestoreに追加
    await FirebaseFirestore.instance.collection('report').doc(book.id).update({
      'dairy': dairy,
    });
  }
}
