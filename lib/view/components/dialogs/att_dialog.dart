import 'package:flutter/material.dart';

//TODO[ATT]
Future<void> openAttDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("広告の表示について"),
        content: Text("このアプリは広告を表示することで無料化を実現しています。"
            "パーソナライズされた広告の表示を許可して頂けるかどうかを次のダイアログで選択してください。"
            "お客様のプライバシーとデータの安全性には最新の注意を払っています。 "
            "アプリの設定でいつでも選択を変更することができます。"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("進む"),
          ),
        ],
      );
    },
  );
}
