import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:quote_generator/presentation/ViewAllQuote.dart';
import 'package:quote_generator/common_widget/colors.dart';
import 'package:quote_generator/data/notifications.dart';
import 'package:quote_generator/controllers/quote_controller.dart';
import 'package:quote_generator/data/quote_repo.dart';

import 'common_widget/styles.dart';
import 'presentation/home_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(black18),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.purple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: AppColors.light,
                          ))))),
          scaffoldBackgroundColor: AppColors.light,
          fontFamily: 'Roboto',
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 20)),
          brightness: Brightness.light),
      home: const HomePage(),
    );
  }
}
