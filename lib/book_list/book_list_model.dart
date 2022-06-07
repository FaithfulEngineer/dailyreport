import 'dart:math';

import '/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookListModel extends ChangeNotifier {
  List<Book>? books;
  DateTime? now;
  String? email;

  void fetchBookList(String email, String type) async {
    DateTime now = DateTime.now();
    DateTime _staDate;
    DateTime _endDate;

    _staDate = DateTime(now.year, now.month, 1);
    _endDate = DateTime(now.year, now.month + 1, 1);

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('email', isEqualTo: email)
        //.where('type', isEqualTo: Type) 設定するとアベンドする。
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(_staDate))
        .where('date', isLessThan: Timestamp.fromDate(_endDate))
        .where('delflg', isEqualTo: '0')
        .get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final DateTime reportdated = data['date'].toDate();
      final String reportdate = DateFormat.MMMEd('ja').format(reportdated);
      final String dairy = data['dairy'];
      final String contents = data['contents'];
      final String email = data['email'];
      final String style = data['style'];
      final String unit = data['unit'];
      final String plan = 'NNNNNNN';
      return Book(id, type, reportdate, reportdated, dairy, email, contents,
          style, unit, plan);
    }).toList();

    List<Book> newbooks;
    newbooks = books.where((element) => element.type == type).toList();

    List<Book> cal;
    cal = makecal(newbooks, type);

    books.addAll(cal);
    books.sort((a, b) => a.reoportdated.compareTo(b.reoportdated));

    this.books = books.where((element) => element.type == type).toList();

    notifyListeners();
  }

  // 今月の日にちリストを作成する
  List<Book> makecal(List<Book> book, String ctype) {
    List<Book> cal;
    List<DateTime> datelist2 = [];
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    final lastDate = DateTime(year, month + 1, 0);
    final currentDayCount = lastDate.day;

    if (book.length == 0) return book; //ゼロ件の場合アベンドしないようにする。

    book = book.where((e) => e.reoportdated.month == month).toList();
    book.sort((a, b) => a.reoportdated.compareTo(b.reoportdated));

    final ccontents = book.first.contets;
    final cstyle = book.first.style;
    final cunit = book.first.unit;
    final cemail = book.first.email;

    for (var day = 1; day < currentDayCount + 1; day++) {
      datelist2.add(
        DateTime(year, month, day),
      );
    }

    cal = datelist2.map((DateTime e) {
      final String id = '';
      final String type = ctype;
      final String contents = ccontents;
      final DateTime reportdated = DateTime(e.year, e.month, e.day);
      final String reportdate = DateFormat.MMMEd('ja').format(reportdated);
      final dairy = '';
      final email = cemail;
      final style = cstyle;
      final unit = cunit;
      final plan = 'NNNNNNN';
      return Book(id, type, reportdate, reportdated, dairy, email, contents,
          style, unit, plan);
    }).toList();

    int idx = 1;
    List<int> dells = [0];

    cal.forEach((element) {
      book.forEach((element2) {
        if (element.reoportdated.difference(element2.reoportdated).inDays ==
                0 &&
            element.reoportdated.day == element2.reoportdated.day) {
          dells.add(idx);
        }
      });
      idx++;
    });

    dells = dells.toSet().toList();

    int _idx = 0;
    int _cnt = 0;
    for (_idx in dells) {
      if (_idx != 0) cal.removeAt(_idx - _cnt);
      _cnt++;
    }
    return cal;
  }

  void updatevalue(String mode, Book book) async {
    if (mode == '1') {
      //追加
      await FirebaseFirestore.instance.collection('report').add({
        'date': book.reoportdated,
        'type': book.type,
        'dairy': book.diary,
        'email': email,
        'contents': book.contets,
        'style': book.style,
        'unit': book.unit,
        'delflg': '0',
      });
    } else if (mode == '2') {
      //更新
      await FirebaseFirestore.instance
          .collection('report')
          .doc(book.id)
          .update({
        'date': book.reoportdated,
        'dairy': book.diary,
        'delflg': '0',
      });
    }
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setdate(DateTime date) {
    this.now = date;
    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance
        .collection('report')
        .doc(book.id)
        .delete();
  }
}
