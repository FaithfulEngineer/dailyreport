import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;
  bool loginflg = true;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  bool setflg() {
    if (loginflg)
      this.loginflg = false;
    else
      this.loginflg = true;

    notifyListeners();
    return this.loginflg;
  }

  void idlogin() {
    this.email = titleController.text;
    if (email == 'NA' || email == "") {
      throw 'ユーザIDが設定されていません';
    }
  }

  Future login() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if (email != null && password != null) {
      // ログイン
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'user-not-found':
            throw 'emailが登録されていません';
          case 'wrong-password':
            throw 'パスワードが違います';
          default:
            throw 'ログインできません(' + e.code.toString() + ')';
        }
      }
      final currentUser = FirebaseAuth.instance.currentUser;
      final uid = currentUser!.uid;
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    email = 'NA';
  }
}
