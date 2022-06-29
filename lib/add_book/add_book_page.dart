import '/domain/book.dart';
import '/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/setting/setting_list_page.dart';

DateTime? _selectedDate;
TextEditingController _textEditingController = TextEditingController();
String _calltype = '2';

class AddBookPage extends StatelessWidget {
  final Book book;
  final String email;
  final DateTime date;

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
                      enabled: false,
                    ),
                    controller: _textEditingController,
                    onChanged: (text) {
                      // model.reportdated = setDate;
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  _iconset(model.type, 64),
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

/*   Widget _iconset(String? index) {
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
  } */

  Widget _iconset(String? index, double _size) {
    switch (index) {
      case '01':
        return Icon(Icons.account_circle, size: _size, color: Colors.black);
        break;
      case '02':
        return Icon(Icons.info, size: _size, color: Colors.black);
        break;
      case '03':
        return Icon(Icons.check_circle, size: _size, color: Colors.black);
        break;
      case '04':
        return Icon(Icons.article, size: _size, color: Colors.black);
        break;
      case '05':
        return Icon(Icons.schedule, size: _size, color: Colors.black);
        break;
      case '06':
        return Icon(Icons.event, size: _size, color: Colors.black);
        break;
      case '07':
        return Icon(Icons.thumb_up, size: _size, color: Colors.black);
        break;
      case '08':
        return Icon(Icons.sick, size: _size, color: Colors.black);
        break;
      case '09':
        return Icon(Icons.mail, size: _size, color: Colors.black);
        break;
      case '10':
        return Icon(Icons.flag, size: _size, color: Colors.black);
        break;
      case '11':
        return Icon(Icons.report, size: _size, color: Colors.black);
        break;
      case '12':
        return Icon(Icons.camera, size: _size, color: Colors.black);
        break;

      case '13':
        return Icon(Icons.favorite_border, size: _size, color: Colors.black);
        break;

      case '14':
        return Icon(Icons.local_hospital, size: _size, color: Colors.black);
        break;

      case '15':
        return Icon(Icons.paid, size: _size, color: Colors.black);
        break;

      case '16':
        return Icon(Icons.star_rate, size: _size, color: Colors.black);
        break;

      case '17':
        return Icon(Icons.outbound, size: _size, color: Colors.black);
        break;

      case '18':
        return Icon(Icons.lightbulb_outline, size: _size, color: Colors.black);
        break;

      case '19':
        return Icon(Icons.people_alt, size: _size, color: Colors.black);
        break;

      case '20':
        return Icon(Icons.water_drop, size: _size, color: Colors.black);
        break;

      case '21':
        return Icon(Icons.waving_hand, size: _size, color: Colors.black);
        break;

      case '22':
        return Icon(Icons.send, size: _size, color: Colors.black);
        break;

      case '23':
        return Icon(Icons.insights, size: _size, color: Colors.black);
        break;

      case '24':
        return Icon(Icons.edit, size: _size, color: Colors.black);
        break;

      case '25':
        return Icon(Icons.music_note, size: _size, color: Colors.black);
        break;

      case '26':
        return Icon(Icons.bedtime, size: _size, color: Colors.black);
        break;

      case '27':
        return Icon(Icons.currency_yen, size: _size, color: Colors.black);
        break;

      case '28':
        return Icon(Icons.key, size: _size, color: Colors.black);
        break;

      case '29':
        return Icon(Icons.stay_current_portrait,
            size: _size, color: Colors.black);
        break;

      case '30':
        return Icon(Icons.directions_run, size: _size, color: Colors.black);
        break;

      case '31':
        return Icon(Icons.directions_walk, size: _size, color: Colors.black);
        break;

      case '32':
        return Icon(Icons.directions_bike, size: _size, color: Colors.black);
        break;

      case '33':
        return Icon(Icons.fastfood, size: _size, color: Colors.black);
        break;

      case '34':
        return Icon(Icons.directions_bus, size: _size, color: Colors.black);
        break;

      case '35':
        return Icon(Icons.local_florist, size: _size, color: Colors.black);
        break;

      case '36':
        return Icon(Icons.play_circle, size: _size, color: Colors.black);
        break;

      case '37':
        return Icon(Icons.savings, size: _size, color: Colors.black);
        break;

      case '38':
        return Icon(Icons.arrow_right_alt, size: _size, color: Colors.black);
        break;

      case '39':
        return Icon(Icons.pets, size: _size, color: Colors.black);
        break;

      case '40':
        return Icon(Icons.flight_takeoff, size: _size, color: Colors.black);
        break;

      case '41':
        return Icon(Icons.extension, size: _size, color: Colors.black);
        break;

      case '42':
        return Icon(Icons.rocket_launch, size: _size, color: Colors.black);
        break;

      case '43':
        return Icon(Icons.nightlight_round, size: _size, color: Colors.black);
        break;

      case '44':
        return Icon(Icons.anchor, size: _size, color: Colors.black);
        break;

      case '45':
        return Icon(Icons.home_filled, size: _size, color: Colors.black);
        break;

      case '46':
        return Icon(Icons.transcribe, size: _size, color: Colors.black);
        break;

      case '47':
        return Icon(Icons.school, size: _size, color: Colors.black);
        break;

      case '48':
        return Icon(Icons.sports_esports, size: _size, color: Colors.black);
        break;

      case '49':
        return Icon(Icons.self_improvement, size: _size, color: Colors.black);
        break;

      case '50':
        return Icon(Icons.cake, size: _size, color: Colors.black);
        break;

      case '51':
        return Icon(Icons.whatsapp, size: _size, color: Colors.black);
        break;

      case '52':
        return Icon(Icons.emoji_emotions, size: _size, color: Colors.black);
        break;

      case '53':
        return Icon(Icons.front_hand, size: _size, color: Colors.black);
        break;

      case '54':
        return Icon(Icons.woman, size: _size, color: Colors.black);
        break;

      default:
        return Icon(Icons.stop, size: 64, color: Colors.red);
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
