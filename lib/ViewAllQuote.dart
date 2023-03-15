import 'package:flutter/material.dart';
import 'package:quote_generator/QuateModel.dart';

class ViewAllQuote extends StatelessWidget {
  QuoteModel _allquote = QuoteModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _allquote.getQuoteLength(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                color: Colors.white54.withOpacity(0.3),
                child: ListTile(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // title: const Text('AlertDialog Title'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      '\" ${_allquote.getQuoteList[index]['quote']!}\"'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '~ ${_allquote.getQuoteList[index]['author']!}',
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
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
                    title: Text(_allquote.getQuoteList[index]['quote']!),
                    subtitle:
                        Text('~ ${_allquote.getQuoteList[index]['author']!}')),
              ),
            );
          }),
    );
  }
}
