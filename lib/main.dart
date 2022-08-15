import 'book_list/book_list_page.dart';
import '/homepage/report_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('jp');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: '日誌アプリ',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            if (snapshot.hasData) {
              // User が null でなない
              String? _email = FirebaseAuth.instance.currentUser!.email;

              if (_email != null) {
                return ReportHomePage(_email);
              }
            }
            // User が null
            return ReportHomePage('NA');
          }));
}
