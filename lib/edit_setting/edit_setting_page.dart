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
}
