import 'dart:io';

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
import 'package:share_plus/share_plus.dart';

int _idx = 0;
int _cntStars = 0;
bool _donef = false;
String _email = 'NA';
String _calltype = '1';
Color _colorgray = Colors.grey;
Color _colorbluck = Colors.black;
Color _colorblue = Colors.blue;
Color _colorblue2 = Colors.blue.shade900;
Color _colororenge = Colors.orange;
Color? _iconColor;

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
                        if (_email == 'NA') {
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
                        } else {
                          //ログアウト
                          await model.logout();
                          _email = 'NA';
                          model.fetchReportList();
                        }
                      },
                      icon: (_email == 'NA')
                          ? Icon(Icons.login)
                          : Icon(Icons.logout)),
                  IconButton(
                      //個人設定画面表示
                      onPressed: () async {
                        if (_email != 'NA') {
                          _calltype = '1';
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingListPage(
                                  _email, _calltype, model.now!),
                            ),
                          );
                          model.fetchReportList();
                        } else
                          Null;
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
                                //updateモード
                                if (books.style == '1' || books.style == '2') {
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
                                } else if (books.style == '3') {
                                  if (books.diary == '1')
                                    _donef = true;
                                  else
                                    _donef = false;

                                  if (_donef) {
                                    books.diary = '0';
                                    _donef = false;
                                  } else if (_donef == false) {
                                    books.diary = '1';
                                    _donef = true;
                                  }
                                  model.updatevalue('2', books);
                                } else if (books.style == '4') {
                                  _cntStars = int.parse(books.diary);
                                  _cntStars++;
                                  if (_cntStars == 6) _cntStars = 0;
                                  books.diary = _cntStars.toString();
                                  model.updatevalue('2', books);
                                }
                              } else {
                                //insertモード
                                DateTime? _now = model.now;
                                if (_now == null)
                                  _now = DateTime.now();
                                else {
                                  model.setdate(_now);
                                }

                                if (books.style == '1' || books.style == '2') {
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
                                } else if (books.style == '3') {
                                  books.diary = '1';
                                  _donef = true;
                                  model.updatevalue('1', books);
                                } else if (books.style == '4') {
                                  _cntStars++;
                                  if (_cntStars == 6) _cntStars = 0;
                                  books.diary = _cntStars.toString();

                                  model.updatevalue('1', books);
                                }
                              }
                              model.fetchReportList();
                            },
                            onLongPress: () async {
                              final String? title = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookListPage(
                                      _email, books.type, books.contets),
                                ),
                              );
                            },
                            textColor:
                                (books.diary != '') ? _colorblue2 : _colorgray,
                            iconColor:
                                (books.diary != '') ? _colorblue2 : _colorgray,
                            leading: _iconset(books.type, 64),
                            title: Text(books.contets),
                            subtitle: (() {
                              if (books.style == '1') {
                                return Text(books.diary);
                              } else if (books.style == '2') {
                                if (books.diary == '') {
                                  return Text('0' + books.unit);
                                } else {
                                  return Text(books.diary + books.unit);
                                }
                              } else if (books.style == '3') {
                                //Done(1) or NotYet(0)
                                if (books.diary == '1')
                                  _donef = true;
                                else if (books.diary == '0')
                                  _donef = false;
                                else //初期値
                                  _donef = false;
                                return _done(context, _donef);
                              } else if (books.style == '4') {
                                //5段階
                                if (int.tryParse(books.diary) != null) {
                                  _cntStars = int.tryParse(books.diary)!;
                                } else {
                                  _cntStars = int.tryParse('0')!;
                                }

                                return _stars(context, _cntStars);
                              }
                            })(),
                            trailing: Icon(Icons.list_alt_outlined)),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: '共有',
                            color:
                                ((books.style == '1' || books.style == '2') &&
                                        books.diary != '')
                                    ? Colors.blue
                                    : Colors.grey,
                            icon: Icons.share,
                            onTap: () async {
                              if (books.diary != '') {
                                if (books.style == '1') {
                                  String _shareText =
                                      books.contets + ':' + books.diary;
                                  Share.share(_shareText);
                                } else if (books.style == '2') {
                                  String _shareText =
                                      books.contets + books.diary + books.unit;
                                  Share.share(_shareText);
                                }
                              }

                              // 編集画面に遷移（style=1 or 2)
/*                               if (books.style == '1' || books.style == '2') {
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
                              } else if (books.style == '3') {
                                if (_donef) {
                                  _donef = false;
                                } else if (_donef == false) {
                                  _donef = true;
                                }
                                model.updatevalue('2', books);
                              } else if (books.style == '4') {
                                _cntStars++;
                                if (_cntStars == 6) _cntStars = 0;
                                model.updatevalue('2', books);
                              }

                              model.fetchReportList();
 */
                            },
                          ),
                          IconSlideAction(
                            caption: '削除',
                            color: (books.id == '' || books.diary == '')
                                ? Colors.grey
                                : Colors.red,
                            icon: Icons.delete,
                            onTap: () async {
                              if (books.id != '' && books.diary != '') {
                                await showConfirmDialog(context, books, model);
                              }
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
          content: (book.style == '1' || book.style == '2')
              ? Text("『${book.diary}』を削除しますか？")
              : Text("『${book.contets}』を削除しますか？"),
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
                  content: (book.style == '1' || book.style == '2')
                      ? Text("『${book.diary}』を削除しました。")
                      : Text("『${book.contets}』を削除しました。"),
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

Widget _stars(context, _idx) {
  return Row(children: <Widget>[
    Icon((_idx >= 1) ? Icons.star : Icons.star_border,
        color: (_idx >= 1) ? _colorblue2 : _colorgray),
    Icon((_idx >= 2) ? Icons.star : Icons.star_border,
        color: (_idx >= 2) ? _colorblue2 : _colorgray),
    Icon((_idx >= 3) ? Icons.star : Icons.star_border,
        color: (_idx >= 3) ? _colorblue2 : _colorgray),
    Icon((_idx >= 4) ? Icons.star : Icons.star_border,
        color: (_idx >= 4) ? _colorblue2 : _colorgray),
    Icon((_idx >= 5) ? Icons.star : Icons.star_border,
        color: (_idx >= 5) ? _colorblue2 : _colorgray),
  ]);
}

Widget _done(context, bool flg) {
  return Icon((flg) ? Icons.circle_outlined : Icons.clear,
      color: (flg) ? _colorblue2 : _colorgray);
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
