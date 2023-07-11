import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:quote_generator/quote_controller.dart';
import 'package:quote_generator/quote_repo.dart';

import 'ViewAllQuote.dart';
import 'common_widget/styles.dart';
import 'notifications.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    final quote = ref.watch(futureProvider);

    return Scaffold(
        body: SafeArea(
      child: quote.when(
          data: (data) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   margin:
                  //       const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  //   child: Text('Quote'),
                  //   decoration: BoxDecoration(
                  //     color: Colors.pink.shade500,
                  //     borderRadius: BorderRadius.circular(16),
                  //   ),
                  //   height: 400,
                  //   width: double.infinity,
                  // ),
                  GlassmorphicFlexContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    borderRadius: 10,
                    blur: 10,
                    padding: const EdgeInsets.all(20),
                    border: 2,
                    linearGradient: linearGradient,
                    borderGradient: linearGradient2,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 40,
                          width: double.infinity,
                          color: Colors.green.shade900,
                          padding: const EdgeInsets.only(top: 8.0, left: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Tags: ',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                              ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.tags.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text('${data.tags[index]},  ',
                                      style: TextStyle(fontSize: 20));
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
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
                          onPressed: () async {
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
                          // ref.invalidate(quoteListProvider);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ViewAllQuote()));
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF15152B)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFffffff).withOpacity(0.6)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(' View all Quote'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
          error: (stackTrace, error) => Center(
                  child: Column(
                children: [
                  Text(
                      " $error \n error, make sure you have internent connection and reload"),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(futureProvider);
                    },
                    child: const Text('Reload'),
                  )
                ],
              )),
          loading: () => const Center(child: Text('loading...'))),
    ));
  }
}
