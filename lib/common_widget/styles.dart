import 'package:flutter/material.dart';
import 'package:quote_generator/common_widget/colors.dart';

final linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.purple.withOpacity(0.1),
      AppColors.light.withOpacity(0.05),
    ],
    stops: [
      0.1,
      1,
    ]);
final linearGradient2 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    AppColors.purple.withOpacity(0.5),
    AppColors.dark.withOpacity(0.5),
  ],
);
TextStyle black11 = const TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.w500,
);
TextStyle black12 = const TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
);
TextStyle black13 = const TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.w500,
);
const TextStyle black14 = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);

const TextStyle black16 = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);
TextStyle black16b = const TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
);
TextStyle grey10 = const TextStyle(
  color: Color(0xff8C8C8C),
  fontSize: 10.0,
  fontWeight: FontWeight.w500,
);
TextStyle black28 = const TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w500,
);

TextStyle black24 = const TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w400,
);

TextStyle black24b = const TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w600,
);

TextStyle black13b = const TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.w600,
);
TextStyle black15 = const TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
);

TextStyle black18 = const TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
);
TextStyle black32 = const TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.w700,
);
const TextStyle black100 = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.w900,
);

TextStyle black20 = const TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);
