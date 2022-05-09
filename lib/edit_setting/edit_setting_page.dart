import '/domain/setting.dart';
import '/edit_setting/edit_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    enabled: false,
                    controller: model.typeController,
                    decoration: InputDecoration(
                      hintText: '変更できません',
                    ),
                    onChanged: (text) {
                      model.setType(text);
                    },
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
}
