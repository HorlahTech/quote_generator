import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quote_generator/common_widget/alerts.dart';
import 'package:quote_generator/data/quote_repo.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../models/QuateModel.dart';
import '../common_widget/colors.dart';
import '../common_widget/styles.dart';

class QuoteController extends StateNotifier<AsyncValue<void>> {
  QuoteController() : super(const AsyncData(null));

  Uint8List? image;

  Future<void> screenshotQuote(
      {required ScreenshotController controller, data, context}) async {
    const AsyncLoading();
    AsyncValue.guard(() async {
      controller
          .captureFromWidget(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.purple,
            borderRadius: BorderRadius.circular(16),
          ),
          height: 400,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\u201C',
                style: black100.copyWith(
                  fontFamily: 'SpaceGrotesk',
                ),
              ),
              Text(
                data.quote,
                textAlign: TextAlign.center,
                style: black20,
              ),
              Text(
                '\u201D',
                style: black100.copyWith(
                  fontFamily: 'SpaceGrotesk',
                ),
              ),
            ],
          ),
        ),
      )
          .then((capturedImage) async {
        image = capturedImage;
        showAlert(
            title: 'Share As Image',
            content: Image.memory(image!),
            context: context,
            actionText: 'Share',
            action: () async {
              if (image != null) {
                final directory = await getApplicationDocumentsDirectory();
                final imagePath =
                    await File('${directory.path}/image.png').create();

                await imagePath.writeAsBytes(image!);

                /// Share Plugin
                await Share.shareFiles([imagePath.path]);
              }
              print(capturedImage);
            });
      });
    });
  }

  Future<void> copyText({required data, required BuildContext context}) async {
    const AsyncLoading();
    AsyncValue.guard(() async => {
          Clipboard.setData(ClipboardData(text: data.quote)),
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Copied to Clipboard"),
          ))
        });
  }
}

final futureProvider = FutureProvider<QuotModel>((ref) async {
  QuotModel quotemodel = await QuoteRepo.getQuote('/random');
  return quotemodel;
});
final quoteListProvider =
    FutureProvider.autoDispose<List<QuotModel>>((ref) async {
  List<QuotModel> listquotemodel =
      await QuoteRepo.getListOFQuote('/quotes/random?limit=50');
  return listquotemodel;
});
final quoteControllerPtovider =
    StateNotifierProvider<QuoteController, AsyncValue<void>>((
  ref,
) =>
        QuoteController());
