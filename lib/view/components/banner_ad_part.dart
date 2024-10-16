import 'package:ad_in_app_purchases_sample/model/ad_manager.dart';
import 'package:ad_in_app_purchases_sample/vm/view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class BannerAdPart extends StatelessWidget {
  const BannerAdPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Selector<ViewModel, AdManager>(
        selector: (context, vm) => vm.adManager,
        builder: (context, adManager, child) {
          final bannerAd = adManager.bannerAd;
          if (bannerAd == null) {
            return Container();
          } else {
            return Container(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            );
          }
        },
      ),
    );
  }
}
