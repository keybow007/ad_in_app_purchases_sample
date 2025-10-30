import 'package:ad_in_app_purchases_sample/model/ad_manager.dart';
import 'package:ad_in_app_purchases_sample/model/in_app_purchase_manager.dart';
import 'package:flutter/foundation.dart';

class ViewModel extends ChangeNotifier {
  final AdManager adManager = AdManager();
  final InAppPurchasesManager inAppPurchasesManager = InAppPurchasesManager();

  bool get isGoThirdScreenEnabled => inAppPurchasesManager.isGoThirdScreenEnabled;

  bool get isDeleteAd => inAppPurchasesManager.isDeleteAd;



  void initAdmob() async {
    await adManager.initAdmob();
    loadBannerAd();
    notifyListeners();
  }

  void loadBannerAd() {
    adManager.loadBannerAd();
  }

  void showRewardAd({required VoidCallback onRewardEarned}) {
    adManager.showRewardAd(onRewardEarned);
  }

  void showInterstitialAd({required VoidCallback onAdClosed}) {
    adManager.showInterstitialAd(onAdClosed: onAdClosed);
  }

  Future<void> donate() async {
    await inAppPurchasesManager.donate();
    notifyListeners();
  }

  Future<void> purchaseGoThirdScreen() async {
    await inAppPurchasesManager.purchaseGoThirdScreen();
    notifyListeners();
  }

  Future<void> purchaseDeleteAd() async {
    await inAppPurchasesManager.purchaseDeleteAd();
    notifyListeners();
  }

  //アプリ内課金処理の初期化
  void initInAppPurchase() async{
    await inAppPurchasesManager.initInAppPurchase();
    notifyListeners();
  }


}
