import 'dart:math';

import 'package:flutter/foundation.dart';

import '/domain/book.dart';
import '/domain/setting.dart';
import '/domain/homepage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePageModel extends ChangeNotifier {
  List<Book>? books;
  DateTime? now;
  String? email;

  //void fetchReportList(String day, String email) async {
  void fetchReportList() async {
    DateTime _staDate;
    DateTime _endDate;

    if (now == null) now = DateTime.now();
    if (email == null) email = 'NotAvailable';

    _staDate = DateTime(this.now!.year, this.now!.month, this.now!.day);
    _endDate = _staDate.add(Duration(days: 1));

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('email', isEqualTo: email)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(_staDate))
        .where('date', isLessThan: Timestamp.fromDate(_endDate))
        .get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final String contents = data['contents'];
      final DateTime reportdated = data['date'].toDate();
      final String reportdate = DateFormat.yMMMEd('ja').format(reportdated);
      final String dairy = data['dairy'];
      final String email = data['email'];
      return Book(id, type, reportdate, dairy, email, contents);
    }).toList();

    books.sort((a, b) {
      return a.type[0].compareTo(b.type[0]);
    });

    this.books = books;

    notifyListeners();
  }

  void setemail(String email) {
    this.email = email;
    notifyListeners();
  }

//検索日付の設定(未来は明々後日まで、過去は6日間）
  void setday(int idx) {
    var _now = DateTime.now();
    switch (idx) {
      case 1:
        this.now = _now.add(Duration(days: 1)); // day : '+1' => tommorow
        notifyListeners();
        break;
      case 2:
        this.now =
            _now.add(Duration(days: 2)); // day : '+2' => the day after tommorow
        notifyListeners();
        break;
      case 3:
        this.now = _now.add(Duration(days: 3)); // day : '+3' => more
        notifyListeners();
        break;
      case -1:
        this.now = _now.add(Duration(days: -1)); // day : '-1' => yesterday
        notifyListeners();
        break;
      case -2:
        this.now = _now
            .add(Duration(days: -2)); // day : '-2' => the day before yesterday
        notifyListeners();
        break;
      case -3:
        this.now = _now.add(Duration(days: -3)); // day : '-3' => more
        notifyListeners();
        break;
      case -4:
        this.now = _now.add(Duration(days: -4)); // day : '-4' => more
        notifyListeners();
        break;
      case -5:
        this.now = _now.add(Duration(days: -5)); // day : '-5' => more
        notifyListeners();
        break;
      case -6:
        this.now = _now.add(Duration(days: -6)); // day : '-5' => more
        notifyListeners();
        break;

      default:
        this.now = _now; // day : '0' => today
        notifyListeners();

        break;
    }
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
