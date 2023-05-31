import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_generator/quote_repo.dart';

import 'QuateModel.dart';

final futureProvider = FutureProvider.autoDispose((ref) async{
  QuotModel quotemodel = await QuoteRepo.getQuote('/random');
  return quotemodel;
});final quoteListProvider = FutureProvider.autoDispose((ref) async{
  QuotModel quotemodel = await QuoteRepo.getQuote('/quotes');
  return quotemodel;
});