import 'dart:io';

import '/login/login_model.dart';
import '/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool loginflg = true;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    onWillPop:
    () {
      Navigator.of(context).pop();
      return Future.value(false);
    };
    return ChangeNotifierProvider<LoginModel>(
        create: (_) => LoginModel(),
        child: Consumer<LoginModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: (loginflg) ? Text('ログイン') : Text('ユーザＩＤで利用'),
                actions: [
                  /* IconButton(
                      //アプリ終了
                      onPressed: () {
                        loginflg = true;
                        model.logout();
                        exit(0);
                      },
                      //ユーザボタン
                      icon: Icon(Icons.exit_to_app)),*/
                  IconButton(
                      onPressed: () {
                        loginflg = model.setflg();
                      },
                      icon: Icon(Icons.person)),
                ]),
            body: Center(
                child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: model.titleController,
                        decoration: InputDecoration(
                            hintText: (loginflg) ? 'Email' : 'ユーザID'),
                        onChanged: (text) {
                          model.setEmail(text);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: model.authorController,
                        obscureText: true,
                        enabled: (loginflg) ? true : false,
                        decoration: InputDecoration(
                          hintText:
                              (loginflg) ? 'パスワード' : 'ユーザIDを入力し利用開始をタップしてください',
                        ),
                        onChanged: (text) {
                          model.setPassword(text);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (loginflg == true) {
                            model.startLoading();
                            try {
                              await model.login();
                              Navigator.of(context).pop(model.email);
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } finally {
                              model.endLoading();
                            }
                          } else {
                            model.startLoading();
                            try {
                              model.idlogin();
                              Navigator.of(context).pop(model.email);
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } finally {
                              model.endLoading();
                            }
                          }
                        },
                        child: (loginflg) ? Text('ログイン') : Text('利用開始'),
                      ),
                      TextButton(
                        onPressed: loginflg
                            ? () async {
                                // 画面遷移
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                    fullscreenDialog: true,
                                  ),
                                );
                              }
                            : null,
                        child: Text('新規登録の方はこちら'),
                      ),
                    ],
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            )),
          );
        }));
  }
}
