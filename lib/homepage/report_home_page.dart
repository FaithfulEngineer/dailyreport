import 'package:dailyreport/book_list/book_list_page.dart';

import '/domain/book.dart';
import '/domain/homepage.dart';
import '/homepage/report_home_model.dart';

import '/setting/setting_list_page.dart';
import '/setting/icon_select_page.dart';

import '/book_list/book_list_model.dart';
import '/add_book/add_book_page.dart';
import '/edit_book/edit_book_page.dart';
import 'package:dailyreport/login/login_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

String _today = '0'; //仮
String _email = 'NA';
Color? _color = Colors.orange;

class ReportHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
      create: (_) => HomePageModel()..fetchReportList(_today, _email),
      child: Scaffold(
        appBar: AppBar(
          title: Text(DateFormat.yMMMEd('ja').format(DateTime.now()) + '日誌'),
          backgroundColor: _color,
          actions: [
            IconButton(
              onPressed: () async {
                // ログイン画面表示
                final String email = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                    fullscreenDialog: true,
                  ),
                );
                if (email != null) {
                  _email = email;
                  _color = Colors.blue;
                  HomePageModel().setemail();
                  //login中のメッセージアイコンの色を変えるなどできないか
                  //appberをビルドしなおさないと変わらないようです。
                } else
                  _email = 'null';
              },
              icon: Icon(Icons.person),
            ),
            IconButton(
                onPressed: () async {
                  //個人設定画面表示
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
        body: Center(
          child: Consumer<HomePageModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (books) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                        onTap: () {
                          //項目入力をしたいaddbookpage
                        },
                        onLongPress: () async {
                          //日誌一覧 ☆type別にしたい
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookListPage(_email),
                            ),
                          );
                        },
                        leading: _iconset(books.type),
                        title: Text(books.type),
                        subtitle: Text(books.diary),
                        trailing: Icon(Icons.list_alt_outlined)),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: '編集',
                        color: Colors.black45,
                        icon: Icons.edit,
                        onTap: () async {
                          // 編集画面に遷移
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBookPage(books),
                            ),
                          );

                          if (title != null) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('$titleを編集しました'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          model.fetchReportList(_today, _email);
                        },
                      ),
                      IconSlideAction(
                        caption: '削除',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          // 削除しますか？って聞いて、はいだったら削除
                          await showConfirmDialog(context, books, model);
                        },
                      ),
                    ],
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<HomePageModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              //print('add-email' + _email);
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(_email),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('日誌を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchReportList(_today, _email);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  Future showConfirmDialog(
    BuildContext context,
    Book book,
    HomePageModel model,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("『${book.reportdate}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                // modelで削除
                await model.delete(book);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${book.reportdate}を削除しました'),
                );
                model.fetchReportList(_today, _email);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}

Widget _iconset(String index) {
  switch (index) {
    case '1':
      return Icon(Icons.account_circle, size: 64, color: Colors.black);
      break;
    case '2':
      return Icon(Icons.info, size: 64, color: Colors.black);
      break;
    case '3':
      return Icon(Icons.check_circle, size: 64, color: Colors.black);
      break;
    case '4':
      return Icon(Icons.article, size: 64, color: Colors.black);
      break;
    case '5':
      return Icon(Icons.schedule, size: 64, color: Colors.black);
      break;
    case '6':
      return Icon(Icons.event, size: 64, color: Colors.black);
      break;
    case '7':
      return Icon(Icons.thumb_up, size: 64, color: Colors.black);
      break;
    case '8':
      return Icon(Icons.sick, size: 64, color: Colors.black);
      break;
    case '9':
      return Icon(Icons.mail, size: 64, color: Colors.black);

      break;
    case '10':
      return Icon(Icons.flag, size: 64, color: Colors.black);
      break;
    case '11':
      return Icon(Icons.report, size: 64, color: Colors.black);
      break;
    case '12':
      return Icon(Icons.email, size: 64, color: Colors.black);
      break;
    default:
      return Icon(Icons.stop, size: 64, color: Colors.red);
      break;
  }
}
