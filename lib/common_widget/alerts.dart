import 'package:flutter/material.dart';
import 'package:quote_generator/common_widget/colors.dart';
import 'package:quote_generator/common_widget/styles.dart';

Future<void> showAlert(
        {required String title,
        required Widget content,
        required context,
        String? actionText,
        action}) async =>
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: AppColors.light,
              content: content,
              title: Text(
                title,
                style: black18,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: action,
                  child: Text(actionText ?? ''),
                ),
              ],
            ));
