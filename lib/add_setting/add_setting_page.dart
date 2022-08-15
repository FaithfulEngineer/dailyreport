import '/add_setting/add_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dailyreport/setting/icon_select_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

bool _unituseflg = false;

String _sun = '0';
String _mon = '0';
String _tue = '0';
String _wed = '0';
String _thu = '0';
String _fri = '0';
String _sta = '0';

String _weeklyPlan = '0000000';

class AddSettingPage extends StatelessWidget {
  final String email;
  AddSettingPage(this.email) {
    _sun = '0';
    _mon = '0';
    _tue = '0';
    _wed = '0';
    _thu = '0';
    _fri = '0';
    _sta = '0';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddSettingModel>(
      create: (_) => AddSettingModel(),
      child: Scaffold(
        endDrawer: Container(
          width: 70,
          child: Drawer(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text("退会"),
                    onTap: () async {
                      await showConfirmDialog(context);
                    });
              },
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('設定を追加'),
        ),
        body: Center(
          child: Consumer<AddSettingModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final String? title = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Iconsetting(email),
                        ),
                      );
                      if (title != null) {
                        model.typeController.text = title;
                        model.setType(title);
                        model.email = email;
                      }
                    },
                    icon: _iconset(model.type, 64),
                    label: Text('アイコン'),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '内容',
                    ),
                    onChanged: (text) {
                      model.contents = text;
                      model.email = email;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DropdownButton(
                    value: model.style,
                    items: const [
                      DropdownMenuItem(
                        child: Text('日誌型'),
                        value: '1',
                      ),
                      DropdownMenuItem(
                        child: Text('数字型'),
                        value: '2',
                      ),
                      DropdownMenuItem(
                        child: Text('実施/未実施型'),
                        value: '3',
                      ),
                      DropdownMenuItem(
                        child: Text('５段階型'),
                        value: '4',
                      ),
                    ],
                    onChanged: (String? text) {
                      if (text.toString() == '2')
                        _unituseflg = true;
                      else
                        _unituseflg = false;

                      model.setStyle(text.toString());
                    },
                  ),
                  TextField(
                    maxLines: null,
                    enabled: _unituseflg,
                    decoration: InputDecoration(
                      hintText: '単位',
                    ),
                    onChanged: (text) {
                      if (model.style != '2')
                        text = '';
                      else
                        model.unit = text;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('実施日')],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              if (_sun == '0')
                                _sun = '1';
                              else if (_sun == '1') _sun = '0';
                              weeklyplan();
                              model.setplan(_weeklyPlan);
                            },
                            child: Text('日',
                                style: TextStyle(
                                    color: (_sun == '1')
                                        ? Colors.blue
                                        : Colors.grey)),
                          )),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (_mon == '0')
                                _mon = '1';
                              else if (_mon == '1') _mon = '0';
                              weeklyplan();
                              model.setplan(_weeklyPlan);
                            },
                            child: Text('月',
                                style: TextStyle(
                                    color: (_mon == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (_tue == '0')
                                _tue = '1';
                              else if (_tue == '1') _tue = '0';
                              weeklyplan();
                              model.setplan(_weeklyPlan);
                            },
                            child: Text('火',
                                style: TextStyle(
                                    color: (_tue == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (_wed == '0')
                                _wed = '1';
                              else if (_wed == '1') _wed = '0';
                              weeklyplan();
                              model.setplan(_weeklyPlan);
                            },
                            child: Text('水',
                                style: TextStyle(
                                    color: (_wed == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (_thu == '0')
                                _thu = '1';
                              else if (_thu == '1') _thu = '0';
                              weeklyplan();
                              model.setplan(_weeklyPlan);
                            },
                            child: Text('木',
                                style: TextStyle(
                                    color: (_thu == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (_fri == '0')
                                _fri = '1';
                              else if (_fri == '1') _fri = '0';
                              weeklyplan();
                              model.setplan(_weeklyPlan);
                            },
                            child: Text('金',
                                style: TextStyle(
                                    color: (_fri == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (_sta == '0')
                                _sta = '1';
                              else if (_sta == '1') _sta = '0';
                              weeklyplan();
                              model.setplan(_weeklyPlan);
                            },
                            child: Text('土',
                                style: TextStyle(
                                    color: (_sta == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        alldayon();
                        weeklyplan();
                        model.setplan(_weeklyPlan);
                      },
                      child: Text(
                        '毎日',
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      )),
                  ElevatedButton(
                    onPressed: () async {
                      // 追加の処理
                      print(_weeklyPlan);

                      try {
                        await model.addSetting();
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

  void alldayon() {
    _sun = '1';
    _mon = '1';
    _tue = '1';
    _wed = '1';
    _thu = '1';
    _fri = '1';
    _sta = '1';
  }

  void weeklyplan() {
    _weeklyPlan = _sun + _mon + _tue + _wed + _thu + _fri + _sta;
  }

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
        return Icon(Icons.stop, size: 32, color: Colors.red);
        break;
    }
  }

  Future showConfirmDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("退会しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                try {
                  Navigator.pop(context);
                  FirebaseAuth.instance.currentUser?.delete();
                  await FirebaseAuth.instance.signOut();
                } catch (e) {
                  final snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(e.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                final snackBar = SnackBar(
                  backgroundColor: Colors.orange,
                  content: Text("退会しました。APPを終了します。"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                await new Future.delayed(new Duration(seconds: 3));
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}
