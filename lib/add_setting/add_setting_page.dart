import '/add_setting/add_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dailyreport/setting/icon_select_page.dart';

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
                          builder: (context) => Iconsetting(),
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
                  SizedBox(
                    height: 8,
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
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // 追加の処理
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
