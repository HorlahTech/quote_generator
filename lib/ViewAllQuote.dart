import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_generator/common_widget/alerts.dart';
import 'package:quote_generator/common_widget/extentions.dart';
import 'package:quote_generator/onError.dart';
import 'package:quote_generator/quote_controller.dart';

import 'common_widget/colors.dart';

class ViewAllQuote extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listQuote = ref.watch(quoteListProvider);
    final state = ref.watch(quoteControllerPtovider.notifier);
    ref.listen<AsyncValue>(quoteListProvider, (_, state) {
      state.showError(context, action: () {
        ref.invalidate(quoteListProvider);
        Navigator.pop(context);
      }, actionText: 'Refresh');
    });

    GlobalKey _globalKey = GlobalKey();
    return Scaffold(
        key: _globalKey,
        body: listQuote.when(
            data: (data) =>
                ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          color: AppColors.white,
                          child: ListTile(
                              horizontalTitleGap: 8,
                              visualDensity: const VisualDensity(
                                  horizontal: -4),
                              onTap: () {
                                showAlert(
                                  title: data[index].author,
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('\" ${data[index].quote}\"'),


                                      ],
                                    ),
                                  ),
                                  context: context,
                                  actionText: 'Copy',
                                  action: () {
                                    state.copyText(
                                        data: data, context: context);
                                  },
                                );
                              },
                              leading: Text((index + 1).toString()),
                              title: Text(data[index].quote),
                              subtitle: Text('~ ${data[index].author}')),
                        ),
                      );
                    }),
            error: (stackTrace, error) =>
                OnErrorWidget(
                  onPressed: () {
                    ref.invalidate(quoteListProvider);
                  },
                ),
            loading: () =>
            const Center(
                child: CircularProgressIndicator(
                  color: AppColors.purple,
                ))));
  }
}
