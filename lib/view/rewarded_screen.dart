import 'package:ad_in_app_purchases_sample/main.dart';
import 'package:ad_in_app_purchases_sample/vm/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardedScreen extends StatelessWidget {
  const RewardedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO 戻る際に全画面広告（PopScope使おう）
    //https://api.flutter.dev/flutter/widgets/PopScope-class.html
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        _backToHomeWithAd(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _backToHomeWithAd(context),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Text(
            "報酬ゲットしたで〜",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }

  void _backToHomeWithAd(BuildContext context) {
    final vm = context.read<ViewModel>();
    vm.showInterstitialAd(
      onAdClosed: () {
        Navigator.pop(context);
      },
    );
  }
}
