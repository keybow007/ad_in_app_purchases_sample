import 'package:ad_in_app_purchases_sample/view/components/banner_ad_part.dart';
import 'package:ad_in_app_purchases_sample/view/rewarded_screen.dart';
import 'package:ad_in_app_purchases_sample/vm/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  }

  //リワード獲得時の処理は関数渡しすればいい
  void _goSecondScreen() {
    final vm = context.read<ViewModel>();
    vm.showRewardAd(
      onRewardEarned: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RewardedScreen(),
          ),
        );
      },
    );
  }
}
