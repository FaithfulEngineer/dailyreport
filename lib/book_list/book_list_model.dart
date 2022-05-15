import '/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookListModel extends ChangeNotifier {
  List<Book>? books;

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
        .get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String type = data['type'];
      final DateTime reportdated = data['date'].toDate();
      final String reportdate = DateFormat.yMMMEd('ja').format(reportdated);
      final String dairy = data['dairy'];
      final String contents = data['contents'];
      final String email = data['email'];

      return Book(id, type, reportdate, dairy, email, contents);
    }).toList();

    this.books = books.where((element) => element.type == type).toList();
    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
