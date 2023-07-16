import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:quote_generator/common_widget/colors.dart';
import 'package:quote_generator/common_widget/extentions.dart';
import 'package:quote_generator/presentation/onError.dart';
import 'package:quote_generator/controllers/quote_controller.dart';
import 'package:screenshot/screenshot.dart';
import 'ViewAllQuote.dart';
import '../common_widget/styles.dart';
import '../data/notifications.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final NotificationsService _notification;
  late final ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;

  @override
  void initState() {
    _notification = NotificationsService();
    _notification.intitializeNotification();
    _notification.showScheduleNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quote = ref.watch(futureProvider);
    final state = ref.watch(quoteControllerPtovider.notifier);
    ref.listen<AsyncValue>(futureProvider, (_, state) {
      isLoading = state.isLoading;
      state.showError(context, action: () {
        ref.invalidate(futureProvider);
        Navigator.pop(context);
      }, actionText: 'Refresh');
    });
    return Scaffold(
        body: SafeArea(
          child: quote.when(
              data: (data) =>
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              color: AppColors.purple,
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Tags: ',
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                    textAlign: TextAlign.start,
                                  ),
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.tags.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return Text('${data.tags[index]},',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: AppColors.white));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 150,
                            ),
                            Text(
                              '~ ${data.author}',
                              textAlign: TextAlign.center,
                              style: black16,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data.quote,
                                style: black16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Expanded(child: SizedBox.shrink()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      state.copyText(
                                          context: context, data: data);
                                    },
                                    icon: const Icon(Icons.copy)),
                                IconButton(
                                    onPressed: () {
                                      state.screenshotQuote(
                                          controller: screenshotController,
                                          data: data,
                                          context: context);
                                    },
                                    icon: const Icon(Icons.share)),
                              ],
                            )
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
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                ref.invalidate(futureProvider);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(' Get Quote'),
                              )),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ViewAllQuote()));
                            },
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
              error: (stackTrace, error) =>
                  OnErrorWidget(
                    onPressed: () {
                      ref.invalidate(futureProvider);
                    },
                  ),
              loading: () =>
              const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.purple,
                  ))),
        ));
  }
}
