import 'package:ad_in_app_purchases_sample/model/ad_manager.dart';
import 'package:ad_in_app_purchases_sample/model/in_app_purchase_manager.dart';
import 'package:ad_in_app_purchases_sample/view/home_screen.dart';
import 'package:ad_in_app_purchases_sample/vm/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AdManager>(
          create: (context) => AdManager(),
        ),
        Provider<InAppPurchasesManager>(
          create: (context) => InAppPurchasesManager(),
        ),
        ChangeNotifierProvider<ViewModel>(
          create: (context) => ViewModel(
            adManager: context.read<AdManager>(),
            inAppPurchasesManager: context.read<InAppPurchasesManager>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
