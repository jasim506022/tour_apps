import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../others/utilies.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.obscureText = false,
    required this.validatorText,
    this.enabled = true,
  });

  final TextEditingController controller;
  IconData icon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  bool? enabled;
  final String hintText;
  int? maxLines;
  final String validatorText;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
          controller: controller,
          enabled: enabled,
          validator: (value) {
            if (value!.isEmpty) {
              return validatorText;
            }
            return null;
          },
          maxLines: maxLines,
          style: GoogleFonts.inter(
              fontSize: 15,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: Theme.of(context).colorScheme.secondary),
          obscureText: obscureText!,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            prefixIcon: maxLines == 5
                ? Icon(icon, color: utils.getColor)
                : Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                  ),
            labelStyle: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.secondary),
            hintText: hintText,
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class TextFormFieldWidgetWithLabel extends StatelessWidget {
  TextFormFieldWidgetWithLabel({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.obscureText = false,
    required this.validatorText,
    this.enabled = true,
    this.labelttext,
  });

  final TextEditingController controller;
  IconData icon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  bool? enabled;
  final String hintText;
  int? maxLines;
  final String validatorText;
  String? labelttext;
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
          controller: controller,
          enabled: enabled,
          validator: (value) {
            if (value!.isEmpty) {
              return validatorText;
            }
            return null;
          },
          maxLines: maxLines,
          style: GoogleFonts.inter(
              fontSize: 15,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: Theme.of(context).hintColor),
          obscureText: obscureText!,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            label: Text(labelttext!),
            prefixIcon: maxLines == 5
                ? Icon(icon, color: utils.getColor)
                : Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                  ),
            labelStyle: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.secondary),
            hintText: hintText,
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
            ),
          )),
    );
  }
}
