import 'package:cryptx/features/homepage/repo/get_coin_data_repo.dart';
import 'package:cryptx/features/welcome_screen/ui/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});

 GetCoinDataRepo getCoinDataRepo = GetCoinDataRepo();

 void fectcoin () async {
   await getCoinDataRepo.fetchData();
 }


  @override
  Widget build(BuildContext context) {
    fectcoin();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: const WelcomeScreen(),
    );
  }
}