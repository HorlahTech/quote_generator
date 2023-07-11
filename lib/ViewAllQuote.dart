import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_generator/QuateModel.dart';
import 'package:quote_generator/quote_controller.dart';

class ViewAllQuote extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listQuote = ref.watch(quoteListProvider);
    GlobalKey _globalKey = GlobalKey();
    return Scaffold(
        key: _globalKey,
        body: listQuote.when(
            data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.3),
                      child: ListTile(
                          horizontalTitleGap: 8,
                          visualDensity: VisualDensity(horizontal: -4),
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // title: const Text('AlertDialog Title'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('\" ${data[index].quote}\"'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '~ ${data[index].author}',
                                          textAlign: TextAlign.end,
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Icon(Icons.copy),
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: data[index].quote));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Copied to Clipboard"),
                                        ));
                                        ;
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          leading: Text((index + 1).toString()),
                          title: Text(data[index].quote),
                          subtitle: Text('~ ${data[index].author}')),
                    ),
                  );
                }),
            error: (stackTrace, error) => Center(
                    child: Column(
                  children: [
                    Text(
                        " $error \n error, make sure you have internent connection and reload"),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(quoteListProvider);
                      },
                      child: const Text('Reload'),
                    )
                  ],
                )),
            loading: () => const Center(child: Text('loading...'))));
  }
}
