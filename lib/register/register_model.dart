import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;

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

  Future signUp() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if (email != null && password != null) {
      // firebase authでユーザー作成
      User? user;
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-email":
            throw "メールアドレスの形式が違います";

          case "wrong-password":
            throw "パスワードの強度が足りません";

          case "user-not-found":
            throw "このメールアドレスは登録されていません";

          case "user-disabled":
            throw "このメールアドレスは無効です";

          case "email-already-in-use":
            throw "このメールアドレスはすでに使われています";

          default:
            throw "登録出来ません(" + e.code + ')';
        }
      }

      if (user != null) {
        final uid = user.uid;

        // firestoreに追加
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        await doc.set({
          'uid': uid,
          'email': email,
        });
      }
    }
  }
}
