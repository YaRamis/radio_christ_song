import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class AppDefaultTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;

  const AppDefaultTextField({
    super.key,
    required this.textEditingController,
    this.hintText,
    this.maxLength,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      cursorWidth: 1,
      maxLength: maxLength,
      maxLines: maxLines,
      cursorRadius: const Radius.circular(1),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.all(8),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        focusColor: Colors.white,
        counterStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
      ),
    );
  }
}
