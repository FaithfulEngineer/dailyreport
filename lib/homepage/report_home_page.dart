import 'package:dailyreport/domain/homepage.dart';

import '/setting/setting_list_page.dart';
import '/add_book/add_book_page.dart';
import '/homepage/report_home_model.dart';
import '/domain/book.dart';
import '/edit_book/edit_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

String _today = '0'; //仮

class ReportHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
        create: (_) => BookListModel()..fetchReportList(_today), //日付
        child: Scaffold(
            appBar: AppBar(
              title: Text(DateFormat.yMMMEd('ja').format(DateTime.now())),
              actions: [
                IconButton(
                    onPressed: () async {
                      final String? title = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingListPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.construction))
              ],
            ),
            body: Center(child:
                Consumer<BookListModel>(builder: (context, model, child) {
              final HomePage? homepages = model.homepages;

              if (homepages == null) {
                return CircularProgressIndicator();
                //0件処理必要
              }

              child:
              ListTile(
                //leadingにtype別アイコン
                title: Text(homepages.contents),
                subtitle: Text(homepages.dairy),
                //右端のアイコンで画面遷移type別データ取得
              );
            }))));
  }
}
