import 'package:ad_in_app_purchases_sample/view/home_screen.dart';
import 'package:ad_in_app_purchases_sample/vm/view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  print("main関数起動");
  runApp(
    ChangeNotifierProvider(
      create: (context) => ViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    final vm = context.read<ViewModel>();
    vm.initAdmob();
    vm.initInAppPurchase();
  }

  @override
  Widget build(BuildContext context) {
    print("MyApp#build");
    return MaterialApp(
      //theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
