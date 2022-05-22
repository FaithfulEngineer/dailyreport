import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyreport/setting/setting_model.dart';
import '/domain/setting.dart';
import '/add_setting/add_setting_page.dart';
import '/edit_setting/edit_setting_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class SettingListPage extends StatelessWidget {
  final String email;
  final String calledtype; //1:setting add or edit 2:homepage

  SettingListPage(this.email, this.calledtype);

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
        appBar: AppBar(
          title: Text('設定一覧'),
        ),
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
                      leading: _iconset(Setting.type),
                      title: Text(Setting.contents),
                      onTap: () async {
                        //呼ばれた画面によって切替
                        if (calledtype == '1') {
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
                        } else {
                          //HOMEpageから呼ばれたらこっちが動くこと
                          //print("引数" + calledtype);
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
                          // 編集画面に遷移
                          // 画面遷移
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
          content: Text("『${setting.contents}』を削除しますか？"),
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

  Widget _iconset(String index) {
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
        return Icon(Icons.stop, size: 64, color: Colors.red);
        break;
    }
  }
}
