import '/domain/setting.dart';
import '/edit_setting/edit_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dailyreport/setting/icon_select_page.dart';

class EditSettingPage extends StatelessWidget {
  final Setting setting;

  EditSettingPage(this.setting);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditSettingModel>(
      create: (_) => EditSettingModel(setting),
      child: Scaffold(
        appBar: AppBar(
          title: Text('内容を編集'),
        ),
        body: Center(
          child: Consumer<EditSettingModel>(builder: (context, model, child) {
            final List<Setting>? settings; // = model.settings; ;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final String? title = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Iconsetting(setting.email),
                        ),
                      );
                      if (title != null) {
                        model.typeController.text = title;
                        model.setType(title);
                      }
                    },
                    //icon: _iconset(iconNo),
                    icon: _iconset(model.typeController.text, 64),
                    label: Text(
                      'アイコン',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: model.contentsController,
                    decoration: InputDecoration(
                      hintText: '内容',
                    ),
                    onChanged: (text) {
                      model.setContents(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
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
                              if (sun == '0')
                                sun = '1';
                              else if (sun == '1') sun = '0';
                              model.weeklyplan();
                              //model.setplan(weeklyPlan);
                            },
                            child: Text('日',
                                style: TextStyle(
                                    color: (sun == '1')
                                        ? Colors.blue
                                        : Colors.grey)),
                          )),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (mon == '0')
                                mon = '1';
                              else if (mon == '1') mon = '0';
                              model.weeklyplan();
                              //model.setplan(weeklyPlan);
                            },
                            child: Text('月',
                                style: TextStyle(
                                    color: (mon == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (tue == '0')
                                tue = '1';
                              else if (tue == '1') tue = '0';
                              model.weeklyplan();
                              //model.setplan(weeklyPlan);
                            },
                            child: Text('火',
                                style: TextStyle(
                                    color: (tue == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (wed == '0')
                                wed = '1';
                              else if (wed == '1') wed = '0';
                              model.weeklyplan();
                              //model.setplan(weeklyPlan);
                            },
                            child: Text('水',
                                style: TextStyle(
                                    color: (wed == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (thu == '0')
                                thu = '1';
                              else if (thu == '1') thu = '0';
                              model.weeklyplan();
                              //model.setplan(weeklyPlan);
                            },
                            child: Text('木',
                                style: TextStyle(
                                    color: (thu == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (fri == '0')
                                fri = '1';
                              else if (fri == '1') fri = '0';
                              model.weeklyplan();
                              //model.setplan(weeklyPlan);
                            },
                            child: Text('金',
                                style: TextStyle(
                                    color: (fri == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton(
                            onPressed: () {
                              if (sta == '0')
                                sta = '1';
                              else if (sta == '1') sta = '0';
                              model.weeklyplan();
                              //model.setplan(weeklyPlan);
                            },
                            child: Text('土',
                                style: TextStyle(
                                    color: (sta == '1')
                                        ? Colors.blue
                                        : Colors.grey))),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        alldayon();
                        model.weeklyplan();
                        //model.setplan(weeklyPlan);
                      },
                      child: Text(
                        '毎日',
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      )),
                  ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                            // 追加の処理
                            try {
                              await model.update();
                              Navigator.of(context).pop(model.contents);
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
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

  void alldayon() {
    sun = '1';
    mon = '1';
    tue = '1';
    wed = '1';
    thu = '1';
    fri = '1';
    sta = '1';
  }

  Widget _iconset(String? index, double size) {
    switch (index) {
      case '01':
        return Icon(Icons.account_circle, size: size, color: Colors.black);
        break;
      case '02':
        return Icon(Icons.info, size: size, color: Colors.black);
        break;
      case '03':
        return Icon(Icons.check_circle, size: size, color: Colors.black);
        break;
      case '04':
        return Icon(Icons.article, size: size, color: Colors.black);
        break;
      case '05':
        return Icon(Icons.schedule, size: size, color: Colors.black);
        break;
      case '06':
        return Icon(Icons.event, size: size, color: Colors.black);
        break;
      case '07':
        return Icon(Icons.thumb_up, size: size, color: Colors.black);
        break;
      case '08':
        return Icon(Icons.sick, size: size, color: Colors.black);
        break;
      case '09':
        return Icon(Icons.mail, size: size, color: Colors.black);
        break;
      case '10':
        return Icon(Icons.flag, size: size, color: Colors.black);
        break;
      case '11':
        return Icon(Icons.report, size: size, color: Colors.black);
        break;
      case '12':
        return Icon(Icons.camera, size: size, color: Colors.black);
        break;
      default:
        return Icon(Icons.ac_unit, size: 32, color: Colors.red);
        break;
    }
  }
}
