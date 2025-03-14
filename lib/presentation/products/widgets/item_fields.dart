import 'package:flutter/material.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/core/constants/app_styles.dart';

class ItemField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const ItemField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style1,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: kWhite),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.orange[800]!)),
        errorStyle: style1,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: kWhite)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: kWhite)),
      ),
    );
  }
}
