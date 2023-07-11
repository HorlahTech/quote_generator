import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_generator/quote_repo.dart';

import 'QuateModel.dart';

final futureProvider = FutureProvider<QuotModel>((ref) async {
  QuotModel quotemodel = await QuoteRepo.getQuote('/random');
  return quotemodel;
});
final quoteListProvider =
    FutureProvider.autoDispose<List<QuotModel>>((ref) async {
  const AsyncLoading();
  List<QuotModel> listquotemodel =
      await QuoteRepo.getListOFQuote('/quotes/random?limit=50');
  return listquotemodel;
});
