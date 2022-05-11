import '/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookListModel extends ChangeNotifier {
  List<Book>? books;

  void fetchBookList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('report').get();

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
    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
