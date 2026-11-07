
import 'package:contact_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class TextFieldContact extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final OutlineInputBorder? outlineInputBorder;

  const TextFieldContact({
    super.key,
    required this.controller,
    required this.hintText,
    this.outlineInputBorder,
  });

  @override
  Widget build(BuildContext context) {
    final border = outlineInputBorder ?? InputBorder.none;

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: AppColors.whiteColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.whiteColor),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
