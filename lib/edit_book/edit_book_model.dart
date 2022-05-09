import '/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBookModel extends ChangeNotifier {
  final Book book;
  EditBookModel(this.book) {
    dateController.text = book.reportdate;
    dairyController.text = book.diary;
  }

  var dateController = TextEditingController();
  final dairyController = TextEditingController();

  DateTime? date;
  String? dairy;

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

  Future update(DateTime date) async {
    //this.date = date;
    this.dairy = dairyController.text;

    // firestoreに追加
    await FirebaseFirestore.instance.collection('report').doc(book.id).update({
      'date': date,
      'dairy': dairy,
    });
  }
}
