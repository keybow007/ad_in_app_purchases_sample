import 'dart:io';

class AdmobId {
  /*
  * アプリID（テスト用はないので、Admobに登録したテスト用アプリを使う）
  * https://support.google.com/admob/answer/7356431?sjid=17136867898073983742-AP
  *
  * テスト広告ID
  * https://support.google.com/admob/answer/9388275?hl=ja
  * （Android）
  * https://developers.google.com/admob/android/test-ads?hl=ja
  * （iOS）
  * https://developers.google.com/admob/ios/test-ads
  * */

  //TODO[広告] 本番は自分のアプリIDに要変更
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5244464205108027~5322262604";
    } else {
      return "ca-app-pub-5244464205108027~6644846771";
    }
  }

  //TODO[広告] テストIDなので、本番時は本番の広告IDに要変更
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      return "ca-app-pub-3940256099942544/2934735716";
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      return "ca-app-pub-3940256099942544/4411468910";
    }
  }

  static String get rewardAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else {
      return "ca-app-pub-3940256099942544/1712485313";
    }
  }
}