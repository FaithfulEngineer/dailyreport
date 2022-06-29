import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dailyreport/setting/setting_model.dart';
import '/domain/setting.dart';
import '/add_setting/add_setting_page.dart';
import '/edit_setting/edit_setting_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

Color _colorgray = Colors.grey;
Color _colorbluck = Colors.black;
Color _colorblue = Colors.blue;
Color _colorblue2 = Colors.blue.shade900;
Color _colororenge = Colors.orange;

class SettingListPage extends StatelessWidget {
  final DateTime date;
  final String email;
  final String calledtype; //1:setting add or edit 2:homepage

  SettingListPage(this.email, this.calledtype, this.date);

  @override
  Widget build(BuildContext context) {
    onWillPop:
    () {
      Navigator.of(context).pop();
      return Future.value(false);
    };
    return ChangeNotifierProvider<SettingListModel>(
      create: (_) => SettingListModel()..fetchSettingList(email),
      child: Scaffold(
        appBar: AppBar(title: Text('設定一覧'), actions: [
          IconButton(
              //ログアウト
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop('NA');
              },
              icon: Icon(Icons.logout)),
        ]),
        body: Center(
          child: Consumer<SettingListModel>(builder: (context, model, child) {
            final List<Setting>? settings = model.settings;

            if (settings == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = settings
                .map(
                  (Setting) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      leading: _iconset(Setting.type, Setting.plan),
                      title: Text(Setting.contents),
                      onTap: () async {
                        //呼ばれた画面によって切替
                        if (calledtype == '1') {
                          //設定編集画面
/*                           final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditSettingPage(Setting),
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

                          model.fetchSettingList(email); */
                        } else {
                          //HOME画面・日誌入力画面
                          Navigator.of(context).pop(Setting.type +
                              ':' +
                              Setting.contents); //type:contents

                        }
                      },
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: '編集',
                        color: Colors.black45,
                        icon: Icons.edit,
                        onTap: () async {
                          // 編集しない
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditSettingPage(Setting),
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

                          model.fetchSettingList(email);
                        },
                      ),
                      IconSlideAction(
                        caption: '削除',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          // 削除しますか？って聞いて、はいだったら削除
                          await showConfirmDialog(context, Setting, model);
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
        floatingActionButton:
            Consumer<SettingListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSettingPage(email),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('設定を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchSettingList(email);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  Future showConfirmDialog(
    BuildContext context,
    Setting setting,
    SettingListModel model,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("全ての日誌データも削除されます。『${setting.contents}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                // modelで削除
                await model.delete(setting);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${setting.contents}を削除しました'),
                );
                model.fetchSettingList(email);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _iconset(String index, String _weeklyPlan) {
    bool onoff;
    int _weekday;

    if (date.weekday == 7)
      _weekday = 0;
    else
      _weekday = date.weekday;

    if (_weeklyPlan[_weekday] == '1')
      onoff = true;
    else
      onoff = false;

    switch (index) {
      case '01':
        return Icon(Icons.account_circle,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '02':
        return Icon(Icons.info,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '03':
        return Icon(Icons.check_circle,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '04':
        return Icon(Icons.article,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '05':
        return Icon(Icons.schedule,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '06':
        return Icon(Icons.event,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '07':
        return Icon(Icons.thumb_up,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '08':
        return Icon(Icons.sick,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '09':
        return Icon(Icons.mail,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '10':
        return Icon(Icons.flag,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '11':
        return Icon(Icons.report,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '12':
        return Icon(Icons.camera,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '13':
        return Icon(Icons.favorite_border,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '14':
        return Icon(Icons.local_hospital,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '15':
        return Icon(Icons.paid,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '16':
        return Icon(Icons.star_rate,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '17':
        return Icon(Icons.outbound,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '18':
        return Icon(Icons.lightbulb_outline,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '19':
        return Icon(Icons.people_alt,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '20':
        return Icon(Icons.water_drop,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '21':
        return Icon(Icons.waving_hand,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '22':
        return Icon(Icons.send,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '23':
        return Icon(Icons.insights,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '24':
        return Icon(Icons.edit,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '25':
        return Icon(Icons.music_note,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '26':
        return Icon(Icons.bedtime,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '27':
        return Icon(Icons.currency_yen,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '28':
        return Icon(Icons.key,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '29':
        return Icon(Icons.stay_current_portrait,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '30':
        return Icon(Icons.directions_run,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '31':
        return Icon(Icons.directions_walk,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '32':
        return Icon(Icons.directions_bike,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '33':
        return Icon(Icons.fastfood,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '34':
        return Icon(Icons.directions_bus,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '35':
        return Icon(Icons.local_florist,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '36':
        return Icon(Icons.play_circle,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '37':
        return Icon(Icons.savings,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '38':
        return Icon(Icons.arrow_right_alt,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '39':
        return Icon(Icons.pets,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '40':
        return Icon(Icons.flight_takeoff,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '41':
        return Icon(Icons.extension,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '42':
        return Icon(Icons.rocket_launch,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '43':
        return Icon(Icons.nightlight_round,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '44':
        return Icon(Icons.anchor,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '45':
        return Icon(Icons.home_filled,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '46':
        return Icon(Icons.transcribe,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '47':
        return Icon(Icons.school,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '48':
        return Icon(Icons.sports_esports,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '49':
        return Icon(Icons.self_improvement,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '50':
        return Icon(Icons.cake,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;
      case '51':
        return Icon(Icons.whatsapp,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '52':
        return Icon(Icons.emoji_emotions,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '53':
        return Icon(Icons.front_hand,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      case '54':
        return Icon(Icons.woman,
            size: 64, color: (onoff) ? _colorblue2 : _colorgray);
        break;

      default:
        return Icon(Icons.stop, size: 64, color: Colors.red);
        break;
    }
  }
}
