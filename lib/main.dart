import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_generator/common_widget/colors.dart';
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
          useMaterial3: true,
          colorSchemeSeed: AppColors.purple,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(black18),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          scaffoldBackgroundColor: AppColors.light,
          fontFamily: 'Roboto',
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 20)),
          brightness: Brightness.light),
      darkTheme: ThemeData(colorSchemeSeed: AppColors.pink, useMaterial3: true),
      home: const HomePage(),
    );
  }
}
