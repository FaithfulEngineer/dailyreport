import '/domain/book.dart';
import '/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/setting/setting_list_page.dart';
//import 'package:dailyreport/setting/icon_select_page.dart';

DateTime? _selectedDate;
DateTime setDate = DateTime.now();
TextEditingController _textEditingController = TextEditingController();
String _calltype = '2';

class AddBookPage extends StatelessWidget {
  final String email;
  AddBookPage(this.email);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('日誌を追加'),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '日付',
                    ),
                    controller: _textEditingController,
                    onChanged: (text) {
                      model.reportdated = setDate;
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_month, size: 32)),
                  SizedBox(
                    height: 24,
                  ),
                  IconButton(
                    icon: _iconset(model.type),
                    onPressed: () async {
                      _calltype = '2';
                      final String? title = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SettingListPage(email, _calltype),
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
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '日誌',
                    ),
                    onChanged: (text) {
                      model.dairy = text;
                      model.email = email;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // 追加の処理
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
        return Icon(Icons.camera, size: 64, color: Colors.black);
        break;
      default:
        return Icon(Icons.ac_unit, size: 32, color: Colors.red);
        break;
    }
  }
}

_selectDate(BuildContext context) async {
  final newSelectedDate = await showDatePicker(
    context: context,
    initialDate: _selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2040),
  );

  if (newSelectedDate != null) {
    _selectedDate = newSelectedDate;
    setDate = newSelectedDate;
    _textEditingController.text =
        "${setDate.year.toString()}年${setDate.month.toString()}月${setDate.day.toString()}日";
  }
}
