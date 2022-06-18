import '/domain/book.dart';
import '/edit_book/edit_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DateTime? _selectedDate;
DateTime setDate = DateTime.now();
TextEditingController _textEditingController = TextEditingController();

class EditBookPage extends StatelessWidget {
  final Book book;
  EditBookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(book),
      child: Scaffold(
        appBar: AppBar(
          title: (book.style == "1")
              ? Text('${book.contets}を編集')
              : Text('${book.contets}(${book.unit})を編集'),
        ),
        body: Center(
          child: Consumer<EditBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
//日付項目は表示のみのとした。
                  TextField(
                    controller: model.dateController,
                    decoration: InputDecoration(
                      hintText: '日付',
                    ),
                    enabled: false,
                    onChanged: (text) {
                      //チェンジはテキストを直接変更した場合しか実行されない。
                      model.date = setDate;
                    },
                  ),
/*                   IconButton(
                      onPressed: () async {
                        await _selectDate(context);
                        model.dateController.text = _textEditingController.text;
                      },
                      icon: Icon(Icons.calendar_today)),
 */
                  SizedBox(
                    height: 8,
                  ),

                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: Colors.black,
                    controller: model.dairyController,
                    decoration: InputDecoration(
                      hintText: (book.style != '2') ? '日誌' : '数値:${book.unit}',
                    ),
                    onChanged: (text) {
                      if (book.style == '2') {
                        if (int.tryParse(text) != null) {
                          model.dairy = text;
                        } else {
                          text = '';
                        }
                      } else {
                        model.dairy = text;
                      }

                      model.setDairy(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),

/*                   TextField(
                    controller: model.styleController,
                    enabled: false,
                  ), //必要？
                  TextField(
                    controller: model.unitController,
                    enabled: false,
                  ), //必要？
 */
                  ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                            // 追加の処理
                            try {
                              await model.update(setDate);
                              Navigator.of(context).pop(model.date);
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              print(e.toString());
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        : null,
                    child: Text('更新する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

//datepicker日付入力無くなると不要になる。
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
