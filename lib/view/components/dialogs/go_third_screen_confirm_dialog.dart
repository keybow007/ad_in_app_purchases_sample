import 'package:flutter/material.dart';

//TODO[課金]
Future<bool> showGoThirdScreenConfirmDialog(BuildContext context) async {
  String priceString = "";

  //TODO[課金] 課金アイテムの値段を取得（あとでいい）

  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("次の画面に進みますか？"),
      content: Text("課金アイテムを購入すれば、次の画面に進めます。購入しますか？[$priceString]"),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text("購入する"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text("キャンセル"),
        ),
      ],
    ),
  );
}
