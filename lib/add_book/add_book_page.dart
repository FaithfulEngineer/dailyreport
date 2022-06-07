import '/domain/book.dart';
import '/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/setting/setting_list_page.dart';
//import 'package:dailyreport/setting/icon_select_page.dart';

DateTime? _selectedDate;
//DateTime setDate = DateTime.now();
TextEditingController _textEditingController = TextEditingController();
String _calltype = '2';

class AddBookPage extends StatelessWidget {
  final Book book;
  final String email;
  final DateTime date;
//  bool _chgflg = false;

  AddBookPage(this.email, this.book, this.date) {
    _textEditingController.text =
        "${date.year.toString()}年${date.month.toString()}月${date.day.toString()}日";
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(book),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${book.contets}を追加'),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //日付表示欄(表示のみ)
                  TextField(
                    decoration: InputDecoration(
                      hintText: '日付',
                    ),
                    controller: _textEditingController,
                    onChanged: (text) {
                      // model.reportdated = setDate;
                    },
                  ),
                  IconButton(
                      //日付選択ボタン
                      onPressed: () {
                        //  _selectDate(context);
                        //  model.reportdated = setDate;
                      },
                      icon: Icon(Icons.calendar_month, size: 32)),

                  SizedBox(
                    height: 24,
                  ),
                  _iconset(model.type),
//アイコンも選択済みのため表示のみ
/*                   IconButton(
                    //アイコン選択
                    icon: _iconset(model.type),
                    onPressed: () async {
                      _calltype = '2';
                      final String? title = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingListPage(
                              email, _calltype, model.reportdated!),
                        ),
                      );

                      if (title != null) {
                        var temp = title.split(':');

                        model.typeController.text = temp[0];
                        model.contents = temp[1];
                        model.email = email;
                        model.setType(temp[0]);
                      }
                    },
                  ),
 */
                  TextField(
                    //日誌/数値入力欄
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: (model.style != '2') ? '日誌' : '数値:${book.unit}',
                    ),
                    onChanged: (text) {
                      if (model.style == '2') {
                        //数値型
                        if (int.tryParse(text) != null) {
                          model.dairy = text;
                        } else {
                          text = '';
                        }
                      } else {
                        //文字列型
                        model.dairy = text;
                      }
                      //数値文字型共通
                      model.email = email;
                      model.reportdated = date;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    //追加ボタン
                    onPressed: () async {
                      //if (_chgflg == false) model.setDate(date);

                      try {
                        await model.addBook();
                        Navigator.of(context).pop(true);
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text('追加する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _iconset(String? index) {
    switch (index) {
      case '01':
        return Icon(Icons.account_circle, size: 64, color: Colors.black);
        break;
      case '02':
        return Icon(Icons.info, size: 64, color: Colors.black);
        break;
      case '03':
        return Icon(Icons.check_circle, size: 64, color: Colors.black);
        break;
      case '04':
        return Icon(Icons.article, size: 64, color: Colors.black);
        break;
      case '05':
        return Icon(Icons.schedule, size: 64, color: Colors.black);
        break;
      case '06':
        return Icon(Icons.event, size: 64, color: Colors.black);
        break;
      case '07':
        return Icon(Icons.thumb_up, size: 64, color: Colors.black);
        break;
      case '08':
        return Icon(Icons.sick, size: 64, color: Colors.black);
        break;
      case '09':
        return Icon(Icons.mail, size: 64, color: Colors.black);
        break;
      case '10':
        return Icon(Icons.flag, size: 64, color: Colors.black);
        break;
      case '11':
        return Icon(Icons.report, size: 64, color: Colors.black);
        break;
      case '12':
        return Icon(Icons.camera, size: 64, color: Colors.black);
        break;
      default:
        return Icon(Icons.ac_unit, size: 32, color: Colors.red);
        break;
    }
  }

  /*  _selectDate(BuildContext context) async {
    final newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      //setDate = newSelectedDate;
      //_chgflg = true;
      //_textEditingController.text =
      //    "${setDate.year.toString()}年${setDate.month.toString()}月${setDate.day.toString()}日";
    }
  } */
}
