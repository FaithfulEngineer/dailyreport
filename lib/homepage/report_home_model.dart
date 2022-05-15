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
  List<Setting>? settings;
  List<HomePage>? homepages;
  bool chgflg = false;
  bool flag = false;

  void fetchReportList(String day, String email) async {
    DateTime now;
    DateTime _staDate;
    DateTime _endDate;

    var _now = DateTime.now();
    switch (day) {
      case '1':
        now = _now.add(Duration(days: 1)); // day : '+1' => tommorow
        break;
      case '2':
        now =
            _now.add(Duration(days: 2)); // day : '+2' => the day after tommorow
        break;
      case '3':
        now = _now.add(Duration(days: 3)); // day : '+3' => more
        break;
      case '-1':
        now = _now.add(Duration(days: -1)); // day : '-1' => yesterday
        break;
      case '-2':
        now = _now
            .add(Duration(days: -2)); // day : '-2' => the day before yesterday
        break;
      case '-3':
        now = _now.add(Duration(days: -3)); // day : '-3' => more
        break;
      default:
        now = _now; // day : '0' => today
        break;
    }

    _staDate = DateTime(now.year, now.month, now.day);
    _endDate = _staDate.add(Duration(days: 1));

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('email', isEqualTo: email)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(_staDate))
        .where('date', isLessThan: Timestamp.fromDate(_endDate))
        .get();

    //book
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

    // Future<String> tmp;

    /* List? _tmplist;

    books.forEach((element) async {
      final tmp = await getType(element.type);

      element.contets = tmp.toString();
      _tmplist?.add(tmp.toString());
      //print('tmp:' + tmp.toString());
      //booksに戻さないと、反映できない
    });

    print(_tmplist);

    //books.add(_tmplist);

    books.forEach((element) {
      print(element.reportdate);
      print(element.diary);
      print(
        element.type,
      );
      print(element.contets);
      print('--------------------');
    });
 */
    this.books = books;

    this.homepages = homepages;
    notifyListeners();
  }

  void refresh() {
    if (chgflg = true) {
      Future.delayed(const Duration(seconds: 1)).then((_) {
        chgflg = false;
      });
      notifyListeners();
    }
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }

  /* Future<String> getType(String _type) async {
    String val = 'NA';
    //print('func input:' + _type);
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

    settings.sort(((a, b) {
      return a.type[0].compareTo(b.type[0]);
    }));

    settings.forEach((element) {
      //  print('infunc foreach type:' + element.type + ':' + _type);
      if (element.type.compareTo(_type) == 0) {
        val = element.contents;
        flag = true;
      }
    });
    //print('func out:' + val + ':' + flag.toString());

    if (flag) {
      //print(Future<String>.value(val));
      return Future<String>.value(val);
    } else {
      //print(Future<String>.value(val));
      return Future<String>.value('NA');
    }
   }*/

}
