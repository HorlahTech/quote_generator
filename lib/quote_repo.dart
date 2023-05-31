import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quote_generator/QuateModel.dart';
class QuoteRepo{
  QuoteRepo._();


 static  getQuote(String endpoint) async{
   const api = 'https://api.quotable.io';
    final uri = Uri.parse('$api$endpoint');
    try{
      http.Response response = await http.get(uri);
      if(response.statusCode == 200) {
        print(response.body);
         var body =jsonDecode(response.body);
       return  QuotModel.fromJson(body);
      }
      }catch(e){
      print(e);
    }

    }

  }


