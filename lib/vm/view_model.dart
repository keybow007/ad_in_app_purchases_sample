import 'package:ad_in_app_purchases_sample/model/ad_manager.dart';
import 'package:ad_in_app_purchases_sample/model/in_app_purchase_manager.dart';
import 'package:flutter/foundation.dart';

class ViewModel extends ChangeNotifier {
  final AdManager adManager;
  final InAppPurchasesManager inAppPurchasesManager;


  ViewModel({
    required this.adManager,
    required this.inAppPurchasesManager,
  });

  void initAd() async {
    await adManager.initAd();
    adManager.loadBannerAd();
    adManager.loadRewardAd();
    adManager.loadInterstitialAd();
    notifyListeners();
  }

  void showRewardAd({required VoidCallback onRewardEarned}) {
    adManager.showRewardAd(onRewardEarned);
  }

  void showInterstitialAd({required VoidCallback onAdClosed}) {
    adManager.showInterstitialAd(onAdClosed: onAdClosed);
  }



}
