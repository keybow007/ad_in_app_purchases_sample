import 'package:flutter/material.dart';

//TODO[課金]
Future<bool> showConfirmDialog(BuildContext context, {required String title, required String desc}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("サポート頂けませんか"),
      content: Text("このアプリがお役に立ったなら、あなたのご支援を頂けると、とてもうれしいです。"),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text("寄付をする"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text("キャンセル"),
        ),
      ],
    ),
  );
}
