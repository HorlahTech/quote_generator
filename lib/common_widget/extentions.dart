import 'package:flutter/material.dart';
import 'package:quote_generator/common_widget/alerts.dart';
import 'package:riverpod/riverpod.dart';

extension Ui on AsyncValue {
  void showError(context, {action, String? actionText}) {
    if (!isRefreshing && hasError) {
      showAlert(
          title: 'Error',
          content: Text(error.toString()),
          actionText:
              actionText != null || actionText!.isNotEmpty ? actionText : null,
          action: action,
          context: context);
    }
  }
}
