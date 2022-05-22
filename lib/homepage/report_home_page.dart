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

int _idx = 0;
String _email = 'NA';
String _calltype = '1';
Color _colorgray = Colors.grey;
Color _colorbluck = Colors.black;
Color _colorblue = Colors.blue;
Color _colorblue2 = Colors.blue.shade900;
Color _colororenge = Colors.orange;
Color? _iconColor;

//DateTime _dtoday = DateTime.now();
//String _headdate = DateFormat.MMMEd('ja').format(_dtoday);

class ReportHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
        create: (_) => HomePageModel()..fetchReportList(),
        child: Consumer<HomePageModel>(builder: (context, model, child) {
          final List<Book>? books = model.books;

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                title: Text(DateFormat.MMMEd('ja').format(model.now!)),
                backgroundColor: (_email == 'NA') ? _colororenge : _colorblue,
                actions: [
                  IconButton(
                      //ホームボタン
                      onPressed: () async {
                        if (_email != 'NA') {
                          _idx = 0;
                          model.setday(_idx);
                        }

                        model.fetchReportList();
                      },
                      icon: Icon(Icons.home)),
                  IconButton(
                      //一日戻る
                      onPressed: () async {
                        if (_email != 'NA') {
                          _idx--;
                          model.setday(_idx);
                        }

                        model.fetchReportList();
                      },
                      icon: Icon(Icons.arrow_back)),
                  IconButton(
                      //一日進む
                      onPressed: () async {
                        if (_email != 'NA') {
                          _idx++;
                          model.setday(_idx);
                        }
                        model.fetchReportList();
                      },
                      icon: Icon(Icons.arrow_forward)),
                  IconButton(
                    //ログイン
                    onPressed: () async {
                      final String email = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                          fullscreenDialog: true,
                        ),
                      );
                      if (email != null) {
                        _email = email;
                        model.setemail(_email);
                        model.fetchReportList();
                      } else
                        _email = 'NA';
                    },
                    icon: Icon(Icons.person),
                  ),
                  IconButton(
                      //個人設定画面表示
                      onPressed: () async {
                        _calltype = '1';
                        final String? title = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SettingListPage(_email, _calltype),
                          ),
                        );
                      },
                      icon: Icon(Icons.construction))
                ],
              ),
              // })
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
                            onTap: () async {
                              if (books.diary != '') {
                                //編集モード
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
                              } else {
                                //追加モード
                                DateTime? _now = model.now;
                                if (_now == null) _now = DateTime.now();

                                final bool? added = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddBookPage(_email, books, _now!),
                                    fullscreenDialog: true,
                                  ),
                                );

                                if (added != null && added) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('日誌を追加しました'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }

                              model.fetchReportList();
                            },
                            onLongPress: () async {
                              final String? title = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookListPage(_email, books.type),
                                ),
                              );
                            },
                            textColor:
                                (books.diary != '') ? _colorblue2 : _colorgray,
                            iconColor:
                                (books.diary != '') ? _colorblue2 : _colorgray,
                            leading: _iconset(books.type, 64),
                            title: Text(books.contets),
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

                              model.fetchReportList();
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
/*             floatingActionButton:
                Consumer<HomePageModel>(builder: (context, model, child) {
              return FloatingActionButton(
                onPressed: () async {
                  // 画面遷移
                  //print('add-email' + _email);
                  final bool? added = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddBookPage(,_email),
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

                  model.fetchReportList();
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              );
            }            ), */
          );
        }));
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
          content: Text("『${book.diary}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                // modelで削除
                try {
                  await model.delete(book);
                  Navigator.of(context).pop(true);
                } catch (e) {
                  final snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(e.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                final snackBar = SnackBar(
                  backgroundColor: Colors.orange,
                  content: Text('${book.diary}を削除しました'),
                );
                model.fetchReportList();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}

Widget _iconset(String index, double _size) {
  switch (index) {
    case '01':
      return Icon(Icons.account_circle, size: _size);
      break;
    case '02':
      return Icon(Icons.info, size: _size);
      break;
    case '03':
      return Icon(Icons.check_circle, size: _size);
      break;
    case '04':
      return Icon(Icons.article, size: _size);
      break;
    case '05':
      return Icon(Icons.schedule, size: _size);
      break;
    case '06':
      return Icon(Icons.event, size: _size);
      break;
    case '07':
      return Icon(Icons.thumb_up, size: _size);
      break;
    case '08':
      return Icon(Icons.sick, size: _size);
      break;
    case '09':
      return Icon(Icons.mail, size: _size);

      break;
    case '10':
      return Icon(Icons.flag, size: _size);
      break;
    case '11':
      return Icon(Icons.report, size: _size);
      break;
    case '12':
      return Icon(Icons.camera, size: _size);
      break;
    default:
      return Icon(Icons.stop, size: 64, color: Colors.red);
      break;
  }
}
