import '/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DateTime? _selectedDate;
DateTime setDate = DateTime.now();
TextEditingController _textEditingController = TextEditingController();

class AddBookPage extends StatelessWidget {
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
                      //★日付チェックが必要
                      model.reportdated = setDate;
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_today)),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '日誌',
                    ),
                    onChanged: (text) {
                      model.dairy = text;
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
