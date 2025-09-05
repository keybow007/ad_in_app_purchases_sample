import 'package:ad_in_app_purchases_sample/main.dart';
import 'package:ad_in_app_purchases_sample/view/components/dialogs/delete_ad_confirm_dialog.dart';
import 'package:ad_in_app_purchases_sample/view/components/dialogs/donation_confirm_dialog.dart';
import 'package:ad_in_app_purchases_sample/view/components/dialogs/go_third_screen_confirm_dialog.dart';
import 'package:ad_in_app_purchases_sample/view/third_screen.dart';
import 'package:ad_in_app_purchases_sample/vm/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardedScreen extends StatelessWidget {
  const RewardedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //戻る際に全画面広告（PopScope使おう）
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
          //TODO[課金]
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                        onPressed: () => _donate(context),
                        child: Text("投げ銭（消費型）"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                        ),
                        onPressed: () => _goThirdScreen(context),
                        child: Text("次の画面に進む（非消費型）"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                        ),
                        onPressed: () => _deleteAd(context),
                        child: Text("広告非表示（サブスク）"),
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                        ),
                        onPressed: () => _restorePurchases(context),
                        child: Text("購入の復元"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white
                        ),
                        onPressed: () => _canselSubscription(context),
                        child: Text("サブスクの解約"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // child: Text(
          //   "報酬ゲットしたで〜",
          //   style: TextStyle(fontSize: 30.0),
          // ),
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

  //TODO[課金]
  void _donate(BuildContext context) async {
    //TODO 課金するか確認ダイアログ
    final isConfirmed = await showDonationConfirmDialog(context);
    if (isConfirmed) {
      //TODO Yesの場合は課金処理
      final vm = context.read<ViewModel>();
      await vm.donate();
      //TODO 課金が完了したらありがとうございました
    }
  }

  //TODO[課金]
  void _goThirdScreen(BuildContext context) async {
    //TODO 課金するか確認ダイアログ
    final isConfirmed = await showGoThirdScreenConfirmDialog(context);

    if (isConfirmed) {
      //TODO Yesの場合は課金処理

      //TODO 課金が完了したら画面遷移+ありがとうございました
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ThirdScreen()),
      );
    }
  }

  //TODO[課金]
  void _deleteAd(BuildContext context) async {
    //TODO 課金するか確認ダイアログ
    final isConfirmed = await showDeleteAdConfirmDialog(context);

    if (isConfirmed) {
      //TODO Yesの場合は課金処理

      //TODO 課金が完了したら広告非表示+ありがとうございました
    }

  }

  //TODO[課金]
  void _restorePurchases(BuildContext context) {

  }

  //TODO[課金]
  void _canselSubscription(BuildContext context) {

  }
}
