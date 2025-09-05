import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class InAppPurchasesManager {

  late Offerings offerings;

  //課金処理の初期化
  Future<void> initInAppPurchase() async {
    //デバッグログの設定
    await Purchases.setLogLevel(LogLevel.debug);

    //Public APIキーの設定
    if (Platform.isAndroid) {
      await Purchases.configure(
        PurchasesConfiguration("goog_ZlHUjouQljyDQeQHnKHQevUgsKH"),
      );
    } else if (Platform.isIOS) {
      await Purchases.configure(
        PurchasesConfiguration("iOSのAPIキー"),
      );
    }

    //Offeringsの取得
    offerings = await Purchases.getOfferings();

    //TODO 課金アイテムの保有状況をストアから取得


  }

  Future<void> donate() async {
    final package = offerings.all["donate"]?.getPackage("donate");
    if (package == null) return;

    try {
      await Purchases.purchasePackage(package);
    } on PlatformException catch (e) {
      //TODO
      print(e.message);
    }

  }
}
