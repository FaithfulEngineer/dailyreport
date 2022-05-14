import '/domain/book.dart';
import '/domain/setting.dart';
import '/domain/homepage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePageModel extends ChangeNotifier {
  List<Book>? books;
  List<Setting>? settings;
  List<HomePage>? homepages;

  void fetchReportList(String day, String email)
  // day : '0' => today
  // day : '-1' => yesterday
  // day : '-2' => the day before yesterday
  // day : '-3' => more
  // day : '+1' => tommorow
  // day : '+2' => the day after tommorow
  // day : '+3' => more
  // day yyyy/mm/dd 00:00:00とする

  async {
    DateTime now;
    DateTime _staDate;
    DateTime _endDate;

    var _now = DateTime.now();

    switch (day) {
      case '+1':
        now = _now.add(Duration(days: 1));
        break;
      case '+2':
        now = _now.add(Duration(days: 2));
        break;
      case '+3':
        now = _now.add(Duration(days: 3));
        break;
      case '-1':
        now = _now.add(Duration(days: -1));
        break;
      case '-2':
        now = _now.add(Duration(days: -2));
        break;
      case '-3':
        now = _now.add(Duration(days: -3));
        break;
      default:
        now = _now;
        break;
    }

    if (day == '0') {
      _staDate = DateTime(now.year, now.month, now.day);
      _endDate = _staDate.add(Duration(days: 1));
    } else {
      _staDate = DateTime(now.year, now.month, now.day);
      _endDate = _staDate.add(Duration(days: 1));
    }

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('email', isEqualTo: email)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(_staDate))
        .where('date', isLessThan: Timestamp.fromDate(_endDate))
        //.where('type', whereIn: _typeList)
        //.orderBy('type', descending: false)
        .get();

    //book
    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final DateTime reportdated = data['date'].toDate();
      final String reportdate = DateFormat.yMMMEd('ja').format(reportdated);
      final String dairy = data['dairy'];
      final String email = 'NA';
      if (data['email'] != null) {
        final String email = data['email'];
      }
      return Book(id, type, reportdate, dairy, email);
    }).toList();

    this.books = books;

    books.sort((a, b) {
      return a.type[0].compareTo(b.type[0]);
    });

    final QuerySnapshot snapshot2 =
        await FirebaseFirestore.instance.collection('setting').get();

    //setting
    final List<Setting> settings =
        snapshot2.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final String contents = data['contents'];
      return Setting(id, type, contents);
    }).toList();
    this.settings = settings;

    //booksに追加dairyがないところのtype　contens <- daily repに持たせるべきか

    this.homepages = homepages;
    notifyListeners();
  }

  void setemail() {
    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
