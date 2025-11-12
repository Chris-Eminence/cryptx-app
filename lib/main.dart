import 'package:cryptx/features/homepage/repo/get_coin_data_repo.dart';
import 'package:cryptx/features/welcome_screen/ui/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(    ProviderScope(child: MyApp()));


}

class MyApp extends StatelessWidget {
    MyApp({super.key});

 GetCoinDataRepo getCoinDataRepo = GetCoinDataRepo();



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: const WelcomeScreen(),
    );
  }
}