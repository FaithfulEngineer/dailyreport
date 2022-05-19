import '/domain/setting.dart';
import '/edit_setting/edit_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dailyreport/setting/icon_select_page.dart';

class EditSettingPage extends StatelessWidget {
  final Setting setting;
  final String iconNo;
  EditSettingPage(this.setting, this.iconNo);

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
                  _iconset(iconNo, 32),
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
                        //print(iconNo);
                        //var iconNo = title;
                      }
                    },
                    //icon: _iconset(iconNo),
                    icon: _iconset(model.type, 64),
                    label: Text('アイコン'),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
/*                   TextField(
                    enabled: false,
                    controller: model.typeController,
                    decoration: InputDecoration(
                      hintText: '参考type',
                    ),
                    onChanged: (text) {
                      model.setType(text);
                    },
                  ),
 */
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

  Widget _iconset(String? index, double size) {
    print('icon:' + index.toString());

    switch (index) {
      case '1':
        return Icon(Icons.account_circle, size: size, color: Colors.black);
        break;
      case '2':
        return Icon(Icons.info, size: size, color: Colors.black);
        break;
      case '3':
        return Icon(Icons.check_circle, size: size, color: Colors.black);
        break;
      case '4':
        return Icon(Icons.article, size: size, color: Colors.black);
        break;
      case '5':
        return Icon(Icons.schedule, size: size, color: Colors.black);
        break;
      case '6':
        return Icon(Icons.event, size: size, color: Colors.black);
        break;
      case '7':
        return Icon(Icons.thumb_up, size: size, color: Colors.black);
        break;
      case '8':
        return Icon(Icons.sick, size: size, color: Colors.black);
        break;
      case '9':
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
