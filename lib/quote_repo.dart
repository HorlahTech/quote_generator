import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quote_generator/QuateModel.dart';

class QuoteRepo {
  QuoteRepo._();

  static const _api = 'https://api.quotable.io';

  static getQuote(String endpoint) async {
    final uri = Uri.parse('$_api$endpoint');
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return QuotModel.fromJson(body);
      }
    } catch (e) {
      print(e);
    }
  }

  static getListOFQuote(String endpoint) async {
    final uri = Uri.parse('$_api$endpoint');
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        var rawData = jsonDecode(response.body);
        print(rawData);
        // var listQuotes = rawData['results'];
        // print(listQuotes);
        return QuotModel.quoteListfromJson(rawData);
      }
    } catch (e) {
      print(e);
    }
  }
}
