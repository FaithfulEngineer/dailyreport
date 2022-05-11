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

  void fetchReportList(String day)
  // day : '0' => today
  // day : '-1' => yesterday
  // day : '-2' => the day before yesterday
  // day : '-3' => more
  // day : '+1' => tommorow
  // day : '+2' => the day after tommorow
  // day : '+3' => more
  // day yyyy/mm/dd 00:00:00とする
  // DateTime _stadate = DateTime.now();

  async {
    var now = DateTime.now();
    DateTime _staDate;
    DateTime _endDate;

    // switch　に変更する事
    if (day == '0') {
      _staDate = DateTime(now.year, now.month, now.day);
      _endDate = _staDate.add(Duration(days: 1));
    } else {
      _staDate = DateTime(now.year, now.month, now.day);
      _endDate = _staDate.add(Duration(days: 1));
    }

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(_staDate))
        .where('date', isLessThan: Timestamp.fromDate(_endDate))
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

    this.homepages = homepages;
    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
