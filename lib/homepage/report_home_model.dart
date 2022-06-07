import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        .where('delflg', isEqualTo: '0')
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
      final String style = data['style'];
      final String unit = data['unit'];
      final String plan = 'NNNNNNN';

      return Book(id, type, reportdate, reportdated, dairy, email, contents,
          style, unit, plan);
    }).toList();

//ダサいからクラス分けること

    final QuerySnapshot snapshot2 = await FirebaseFirestore.instance
        .collection('setting')
        .where('email', isEqualTo: email)
        .get();

    final List<Book> books2 = snapshot2.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final DateTime reportdated = now!;
      final String reportdate = DateFormat.yMMMEd('ja').format(now!);
      final String dairy = "";
      final String email = data['email'];
      final String contents = data['contents'];
      final String style = data['style'];
      final String unit = data['unit'];
      final String plan = data['plan'];

      return Book(id, type, reportdate, reportdated, dairy, email, contents,
          style, unit, plan);
    }).toList();

    books2.sort(
      (a, b) {
        int ret = a.type[0].compareTo(b.type[0]);
        if (ret != 0) return ret;
        return a.type[1].compareTo(b.type[1]);
      },
    );
    //日毎やらない事を除外
    int _weekday;
    if (_staDate.weekday == 7)
      _weekday = 0;
    else
      _weekday = _staDate.weekday;

    int _idx = 0;
    List<int> dells = books2.map((e) {
      _idx++;
      if (e.plan[_weekday] == '0')
        return _idx - 1;
      else
        return 99 - (_idx - 1);
    }).toList();

    dells = dells.toSet().toList();

    _idx = 0;
    int _cnt = 0;
    for (_idx in dells) {
      if (_idx <= 50) {
        books2.removeAt(_idx - _cnt);
        _cnt++;
      }
    }
    //実施済みリストと結合
    books.addAll(books2);
    books.sort((a, b) {
      int ret = a.type[0].compareTo(b.type[0]);
      if (ret != 0) return ret;
      return a.type[1].compareTo(b.type[1]);
    });

//重複（登録済み）設定の抽出
    _idx = 0;
    var list = <int>[];
    if (books.length != 0) {
      books.reduce((value, element) {
        if (value.type == element.type) {
          list.add(_idx + 1);
        }
        _idx++;
        return element;
      });
    }

    _cnt = 0; //一件重複を消すごとに、リストの配列が減るためのカウンター
    //ダサいからbook list modelの方を確認して、リファクタリングすること
    for (_idx in list) {
      if (_cnt == 0) books.removeAt(_idx);
      if (_cnt == 1) books.removeAt(_idx - 1);
      if (_cnt == 2) books.removeAt(_idx - 2);
      if (_cnt == 3) books.removeAt(_idx - 3);
      if (_cnt == 4) books.removeAt(_idx - 4);
      if (_cnt == 5) books.removeAt(_idx - 5);
      if (_cnt == 6) books.removeAt(_idx - 6);
      if (_cnt == 7) books.removeAt(_idx - 7);
      if (_cnt == 8) books.removeAt(_idx - 8);
      if (_cnt == 9) books.removeAt(_idx - 9);
      if (_cnt == 10) books.removeAt(_idx - 10);
      if (_cnt == 11) books.removeAt(_idx - 11);
      if (_cnt == 12) books.removeAt(_idx - 12);
      _cnt++;
    }
    ;

    books.sort((a, b) {
      return a.type[0].compareTo(b.type[0]);
    });

    this.books = books;
    notifyListeners();
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

//消すこと
/*   void printbook(List<Book> book) {
    book.forEach((element) {
      print(element.type);
      print(element.contets);
      print(element.diary);
    });
  }

  void setupdata(String email) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('setting')
        .where('email', isEqualTo: email)
        .get();

    final List<Book> books2 = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final DateTime reportdated = data['date'].toDate();
      final String reportdate = DateFormat.yMMMEd('ja').format(DateTime.now());
      final String dairy = "";
      final String email = data['email'];
      final String contents = data['contents'];
      final String style = data['style'];
      final String unit = data['unit'];

      return Book(id, type, reportdate, reportdated, dairy, email, contents,
          style, unit);
    }).toList();

    books2.sort((a, b) {
      return a.type[0].compareTo(b.type[0]);
    });

    books!.addAll(books2);
  }
 */ //ここまで消す

  void setemail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setdate(DateTime date) {
    this.now = date;
    notifyListeners();
  }

//検索日付の設定
  void setday(int idx) {
    var _now = DateTime.now();
    this.now = _now.add(Duration(days: idx));
    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance
        .collection('report')
        .doc(book.id)
        .delete();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    email = 'NA';
  }
}
