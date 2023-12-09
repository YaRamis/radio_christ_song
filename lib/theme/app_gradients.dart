import 'package:flutter/material.dart';
import 'package:radio_christ_song/theme/app_colors.dart';

abstract class AppGradients {
  static const defaultGradient = LinearGradient(colors: [
    AppColors.blue,
    AppColors.green,
  ]);
  static const defaultGreenGradient = LinearGradient(colors: [
    AppColors.darkGreen,
    AppColors.green,
  ]);
}
