import '/domain/book.dart';
import '/domain/setting.dart';
import '/domain/homepage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookListModel extends ChangeNotifier {
  List<Book>? books;
  List<Setting>? settings;
  HomePage? homepages;

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

    var list = [];
    var list2 = [];
    var list3 = [];
    var list4 = [];
    var homepagelist = [];

    String _type = "";
    int _con = 0;
    int _con1 = 0;

    // switch　に変更する事
    if (day == '0') {
      _staDate = DateTime(now.year, now.month, now.day);
      _endDate = _staDate.add(Duration(days: 1));
    } else {
      _staDate = DateTime(now.year, now.month, now.day);
      _endDate = _staDate.add(Duration(days: 1));
    }

    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('setting').get();

    final QuerySnapshot snapshot2 = await FirebaseFirestore.instance
        .collection('report')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(_staDate))
        .where('date', isLessThan: Timestamp.fromDate(_endDate))
        .get();

    snapshot.docs.forEach((Element) {
      list.add(Element.get('type'));
      list2.add(Element.get('contents'));
    });
    snapshot2.docs.forEach((Element) {
      list3.add(Element.get('dairy'));
      list4.add(Element.get('type'));
    });

    for (final i in list) {
      for (final j in list4) {
        if (list[_con1] == list4[_con]) {
          homepagelist.add(j);
          homepages?.type = j; // CLASS
          homepagelist.add(list2[_con1]);
          homepages?.contents = list2[_con1]; // CLASS
          homepagelist.add(list3[_con]);
          homepages?.dairy = list3[_con]; // CLASS
          _con = 0;
          _con1++;
          _type = '1';
          break;
        } else
          _con++;
      }
      if (_type != '1') {
        homepagelist.add(i);
        homepages?.type = i; // CLASS
        homepagelist.add(list2[_con1]);
        homepages?.contents = list2[_con1]; // CLASS
        homepagelist.add("");
        homepages?.dairy = ""; // CLASS
        _con1++;
        _con = 0;
        _type = '';
      } else
        _type = '';
    }

    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
