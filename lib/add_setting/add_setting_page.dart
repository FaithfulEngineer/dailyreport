import '/add_setting/add_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dailyreport/setting/icon_select_page.dart';

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
  AddSettingPage(this.email);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddSettingModel>(
      create: (_) => AddSettingModel(),
      child: Scaffold(
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
                    icon: _iconset(model.type),
                    label: Text('アイコン'),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                  ),

//                  IconButton(
//                    icon: _iconset(model.type),
//                    onPressed: () async {
//                      final String? title = await Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => Iconsetting(),
//                        ),
//                      );
//                      if (title != null) {
//                        model.typeController.text = title;
//                        model.setType(title);
//                        model.email = email;
//                      }
//                    },
//                  ),
//                  TextField(
//                    enabled: false,
//                    controller: model.typeController,
//                    decoration: InputDecoration(
//                    //  hintText: 'アイコンを選択',
//                    ),
//                    onChanged: (text) {
//                      model.type = text;
//                    },
//                  ),
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
                  SizedBox(
                    height: 12,
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

                  SizedBox(
                    height: 12,
                  ),

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
}
