import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class InAppPurchasesManager {

  late Offerings offerings;

  bool isGoThirdScreenEnabled = false;

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
    final customerInfo = await Purchases.getCustomerInfo();
    updatePurchase(customerInfo);
    print("bbbb");
  }

  Future<void> donate() async {
    final package = offerings.all["donate"]?.getPackage("donate");
    if (package == null) return;

    try {
      await Purchases.purchasePackage(package);


    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        Fluttertoast.showToast(msg: "購入処理はユーザーにキャンセルされました。");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        Fluttertoast.showToast(msg: "購入処理は許可されていません。");
      } else {
        Fluttertoast.showToast(msg: "購入処理に失敗しました。");
      }
    }

  }

  Future<void> purchaseGoThirdScreen() async {
    final package = offerings.all["go_third_screen"]?.lifetime;
    if (package == null) return;

    try {
      final customerInfo = await Purchases.purchasePackage(package);
      //TODO Entitlementに応じて機能設定
      updatePurchase(customerInfo);

    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        Fluttertoast.showToast(msg: "購入処理はユーザーにキャンセルされました。");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        Fluttertoast.showToast(msg: "購入処理は許可されていません。");
      } else {
        Fluttertoast.showToast(msg: "購入処理に失敗しました。");
      }
    }

  }

  void updatePurchase(CustomerInfo customerInfo) {
    final entitlements = customerInfo.entitlements.all;

    if (entitlements["go_third_screen"] == null ? false : entitlements["go_third_screen"]!.isActive){
      //if (entitlements["go_third_screen"]!.isActive) {
      isGoThirdScreenEnabled = true;
    } else {
      isGoThirdScreenEnabled = false;
    }

  }
}
