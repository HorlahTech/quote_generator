import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:quote_generator/ViewAllQuote.dart';
import 'package:quote_generator/notifications.dart';
import 'package:quote_generator/quote_controller.dart';
import 'package:quote_generator/quote_repo.dart';

import 'common_widget/styles.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp( const ProviderScope(child: MyApp()));
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

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>{
  late final NotificationsService _notification;
  @override
  void initState() {
    _notification = NotificationsService();
    _notification.intitializeNotification();
    _notification.showScheduleNotification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
   final quote =  ref.watch(futureProvider);
    return Scaffold(
        body: SafeArea(
          child: quote.when(data: (data)=>Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassmorphicFlexContainer(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                borderRadius: 10,
                blur: 10,
                padding:const EdgeInsets.all(20),
                border: 2,
                linearGradient: linearGradient,
                borderGradient: linearGradient2,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        const Text('tags: ', style: TextStyle(fontSize: 20),textAlign: TextAlign.start,),
                        SizedBox(
width: screenSize.width - 100,
                          height: 20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.tags.length,
                            itemBuilder: (BuildContext context, int index) { return Text(
                                '${data.tags[index]},  ', style: TextStyle(fontSize: 20)); },),
                        ),
                      ],),
                    ),
SizedBox(height: 150,),
                    Text(
                      '~ ${data.author}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.quote,
                        textAlign: TextAlign.center,
                      ),
                    ),


                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: ()  async {
                          ref.invalidate(futureProvider);
                       // await   _notification.showScheduleNotification();
                       // await _notification.showNotification();

                      },
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(' Get Quote'),
                      )),
                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ViewAllQuote()));
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF15152B)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFffffff).withOpacity(0.6)),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.all(20.0),
                      child: Text(' View all Quote'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ), error: (stackTrace, error)=>Center(child: Text("error, make sure you have internet connection")), loading: ()=> const Text('loading...')),
        ));
  }
}
