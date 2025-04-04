import 'dart:io';

import 'package:ad_in_app_purchases_sample/view/components/banner_ad_part.dart';
import 'package:ad_in_app_purchases_sample/view/rewarded_screen.dart';
import 'package:ad_in_app_purchases_sample/vm/view_model.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/dialogs/att_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initAd();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: IconButton(
                onPressed: () => _goSecondScreen(),
                icon: Icon(
                  Icons.play_circle_outline,
                  size: 200.0,
                ),
              ),
            ),
          ),
          BannerAdPart(),
        ],
      ),
    );
  }

  void _initAd() {
    final vm = context.read<ViewModel>();
    vm.initAd();
    //TODO[ATT]
    if (Platform.isIOS) {
      _initAtt();
    }
  }

  //リワード獲得時の処理は関数渡しすればいい
  void _goSecondScreen() {
    final vm = context.read<ViewModel>();
    vm.showRewardAd(
      onRewardEarned: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RewardedScreen(),
          ),
        );
        //前の画面から戻ってきた時に再度バナー広告のロード要
        _loadBannerAd();
      },
    );
  }

  void _loadBannerAd() {
    final vm = context.read<ViewModel>();
    vm.loadBannerAd();
  }

  //TODO[ATT]
  //https://pub.dev/packages/app_tracking_transparency
  void _initAtt() async {
    final attStatus = await AppTrackingTransparency.trackingAuthorizationStatus;

    if (attStatus == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await openAttDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
      print("Attダイアログ閉じた");
    }
    print("initAtt終了");
  }


}
