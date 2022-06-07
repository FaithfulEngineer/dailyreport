import '/setting/setting_list_page.dart';
import '/add_book/add_book_page.dart';
import '/book_list/book_list_model.dart';
import '/domain/book.dart';
import '/edit_book/edit_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

String _calltype = '1';
int _cntStars = 0;
bool _donef = false;

Color _colorgray = Colors.grey;
Color _colorbluck = Colors.black;
Color _colorblue = Colors.blue;
Color _colorblue2 = Colors.blue.shade900;
Color _colororenge = Colors.orange;

class BookListPage extends StatelessWidget {
  final String email;
  final String type;
  final String contents;
  BookListPage(this.email, this.type, this.contents);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(email, type),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${contents}一覧'),
/*           actions: [
            IconButton(
                onPressed: () async {
                  final String? title = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingListPage(email, _calltype),
                    ),
                  );
                },
                icon: Icon(Icons.construction))
          ],
 */
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }
            final List<Widget> widgets = books
                .map(
                  (book) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      onTap: () async {
                        if (book.diary != '') {
                          //updateモード
                          if (book.style == '1' || book.style == '2') {
                            final String? title = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(book),
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
                          } else if (book.style == '3') {
                            if (book.diary == '1')
                              _donef = true;
                            else
                              _donef = false;

                            if (_donef) {
                              book.diary = '0';
                              _donef = false;
                            } else if (_donef == false) {
                              book.diary = '1';
                              _donef = true;
                            }
                            model.updatevalue('2', book);
                          } else if (book.style == '4') {
                            _cntStars = int.parse(book.diary);
                            _cntStars++;
                            if (_cntStars == 6) _cntStars = 0;
                            book.diary = _cntStars.toString();
                            model.updatevalue('2', book);
                          }
                        } else {
                          //追加モード
                          DateTime? _now = book.reoportdated;
                          if (_now == null)
                            _now = DateTime.now();
                          else {
                            model.setdate(_now);
                          }
                          if (book.style == '1' || book.style == '2') {
                            final bool? added = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddBookPage(email, book, _now!),
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
                          } else if (book.style == '3') {
                            book.diary = '1';
                            _donef = true;
                            model.setEmail(email);
                            model.updatevalue('1', book);
                          } else if (book.style == '4') {
                            _cntStars++;
                            if (_cntStars == 6) _cntStars = 0;
                            book.diary = _cntStars.toString();
                            model.setEmail(email);
                            model.updatevalue('1', book);
                          }
                        }

                        model.fetchBookList(email, type);
                      },
                      leading: Text(book.reportdate),
                      title: Text(book.contets),
                      //subtitle: Text(book.diary),
                      subtitle: (() {
                        //初期表示
                        if (book.style == '1') {
                          return Text(book.diary);
                        } else if (book.style == '2') {
                          if (book.diary == '') {
                            return Text('0' + book.unit);
                          } else {
                            return Text(book.diary + book.unit);
                          }
                        } else if (book.style == '3') {
                          //Done(1) or NotYet(0)
                          if (book.diary == '1')
                            _donef = true;
                          else if (book.diary == '0')
                            _donef = false;
                          else //初期値
                            _donef = false;
                          return _done(context, _donef);
                        } else if (book.style == '4') {
                          //5段階
                          if (int.tryParse(book.diary) != null) {
                            _cntStars = int.tryParse(book.diary)!;
                          } else {
                            _cntStars = int.tryParse('0')!;
                          }

                          return _stars(context, _cntStars);
                        }
                      })(),
                    ),
                    secondaryActions: <Widget>[
                      /* IconSlideAction(
                        caption: '編集',
                        color: Colors.black45,
                        icon: Icons.edit,
                        onTap: () async {
                          if (book.diary != '') {
                            // 編集画面に遷移
                            final String? title = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(book),
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
                            DateTime? _now = book.reoportdated;
                            if (_now == null) _now = DateTime.now();

                            final bool? added = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddBookPage(email, book, _now!),
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

                          model.fetchBookList(email, type);
                        }, ),
                        */
                      IconSlideAction(
                        caption: '削除',
                        color: (book.id == '' || book.diary == '')
                            ? Colors.grey
                            : Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          // 削除確認
                          if (book.id != '' && book.diary != '') {
                            await showConfirmDialog(context, book, model);
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
/*         floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddBookPage(email, type, DateTime.now()), //必ず今日になる
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

              model.fetchBookList(email, type);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
 */
      ),
    );
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

  Future showConfirmDialog(
    BuildContext context,
    Book book,
    BookListModel model,
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
                await model.delete(book);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: (book.style == '1' || book.style == '2')
                      ? Text("『${book.diary}』を削除しました。")
                      : Text("『${book.contets}』を削除しました。"),
                );
                model.fetchBookList(email, type);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}
