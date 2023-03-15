import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:quote_generator/QuateModel.dart';
import 'package:quote_generator/ViewAllQuote.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: Color(0xFFffffff),
                          ))))),
          scaffoldBackgroundColor: Color(0xff15172B),
          textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 25)),
          brightness: Brightness.dark),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuoteModel _quoteModel = QuoteModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          GlassmorphicFlexContainer(
            margin: EdgeInsets.symmetric(horizontal: 20),
            borderRadius: 10,
            blur: 10,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            border: 2,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff).withOpacity(0.1),
                  Color(0xFFFFFFFF).withOpacity(0.05),
                ],
                stops: [
                  0.1,
                  1,
                ]),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.5),
                Color((0xFFFFFFFF)).withOpacity(0.5),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '~ ${_quoteModel.getAuthor()!}',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  _quoteModel.getQuote()!,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_quoteModel.isLastQuote()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('You have reach the last quote'),
                          action: SnackBarAction(
                              label: 'Reset',
                              onPressed: () {
                                setState(() {
                                  _quoteModel.setQuoteNumber = 0;
                                });
                              }),
                        ));
                      }
                      _quoteModel.nextQuote();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(' Get Quote'),
                  )),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ViewAllQuote()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(' View all Quote'),
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF15152B)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFffffff).withOpacity(0.6)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 70,
          ),
        ],
      )),
    );
  }
}
