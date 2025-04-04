import 'package:ad_in_app_purchases_sample/data/admob_ids.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/*
* FlutterでのAdmob（広告）の設定
* https://developers.google.com/admob/flutter/quick-start?hl=ja
* */

class AdManager {
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  Future<void> initAd() async {
    await initAdmob();
    initBannerAd();
  }

  //[広告]MobileAdsSDKを初期化
  //https://developers.google.com/admob/flutter/quick-start?hl=ja#initialize_the_mobile_ads_sdk
  Future<void> initAdmob() {
    return MobileAds.instance.initialize();
  }

  //[広告]バナー広告
  //https://developers.google.com/admob/flutter/banner?hl=ja
  void initBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AdmobId.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print("バナー広告のロード成功");
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          print("バナー広告のロード失敗: ${error.code} / ${error.message}");
        },
      ),
    );
  }

  void loadBannerAd() {
    bannerAd?.load();
  }

  void disposeBannerAd() {
    bannerAd?.dispose();
    bannerAd = null;
  }

  //[広告]全画面広告
  //https://developers.google.com/admob/flutter/interstitial?hl=ja
  Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdmobId.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (InterstitialAd ad) {
          print("全画面広告のロード成功");
          //（これは要る） Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          print('全画面広告のロード失敗: ${error.code} | ${error.message}');
          interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitialAd({required VoidCallback onAdClosed}) async {
    if (interstitialAd == null) return;
    //FullScreenContentCallback: チュートリアルではloadメソッドに内包させているが、
    //閉じた際のコールバックをshow内に入れたいので、こっちに移動させよう
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      // Called when the ad showed the full screen content.
      onAdShowedFullScreenContent: (ad) {
        print("[全画面広告]onAdShowedFullScreenContent");
      },
      // Called when an impression occurs on the ad.
      onAdImpression: (ad) {
        print("[全画面広告]onAdImpression");
      },
      // Called when the ad failed to show full screen content.
      onAdFailedToShowFullScreenContent: (ad, err) {
        print("[全画面広告]onAdFailedToShowFullScreenContent");
        // 広告にアクセスする必要がなくなったら、広告を破棄する必要あり
        ad.dispose();
      },
      // Called when the ad dismissed full screen content.
      onAdDismissedFullScreenContent: (ad) {
        print("[全画面広告]onAdDismissedFullScreenContent");
        // 広告にアクセスする必要がなくなったら、広告を破棄する必要あり
        ad.dispose();
        onAdClosed();
        loadInterstitialAd();
      },
      // Called when a click is recorded for an ad.
      onAdClicked: (ad) {
        print("[全画面広告]onAdClicked");
      },
    );

    interstitialAd?.show();
  }

  void disposeInterstitialAd() {
    interstitialAd?.dispose();
    interstitialAd = null;
  }

  //[広告]リワード広告（全画面広告と同じような実装）
  //https://developers.google.com/admob/flutter/rewarded?hl=ja
  Future<void> loadRewardAd() async {
    await RewardedAd.load(
      adUnitId: AdmobId.rewardAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print("リワード広告のロード成功");

          //（これは要る） Keep a reference to the ad so you can show it later.
          rewardedAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          print('リワード広告のロード失敗: ${error.code} | ${error.message}');
        },
      ),
    );
  }

  //https://developers.google.com/admob/flutter/rewarded?hl=ja#display_ad
  void showRewardAd(VoidCallback onRewardEarned) async {
    if (rewardedAd == null) return;
    //FullScreenContentCallback: チュートリアルではloadメソッドに内包させているが、
    //閉じた際のコールバックをshow内に入れたいので、こっちに移動させよう
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      // Called when the ad showed the full screen content.
      onAdShowedFullScreenContent: (ad) {
        print("[リワード広告]onAdShowedFullScreenContent");
      },
      // Called when an impression occurs on the ad.
      onAdImpression: (ad) {
        print("[リワード広告]onAdImpression");
      },
      // Called when the ad failed to show full screen content.
      onAdFailedToShowFullScreenContent: (ad, err) {
        print("[リワード広告]onAdFailedToShowFullScreenContent");
        // 広告にアクセスする必要がなくなったら、広告を破棄する必要あり
        ad.dispose();
      },
      // Called when the ad dismissed full screen content.
      onAdDismissedFullScreenContent: (ad) {
        print("[リワード広告]onAdDismissedFullScreenContent");
        // 広告にアクセスする必要がなくなったら、広告を破棄する必要あり
        ad.dispose();
        loadRewardAd();
      },
      // Called when a click is recorded for an ad.
      onAdClicked: (ad) {
        print("[リワード広告]onAdClicked");
      },
    );

    rewardedAd?.show(
      onUserEarnedReward: (ad, rewardItem) {
        onRewardEarned();
        loadRewardAd();
      },
    );
  }
}
