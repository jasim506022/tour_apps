

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.obscureText = false});

  final TextEditingController controller;
  final IconData icon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
          controller: controller,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            labelStyle: GoogleFonts.inter(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
                color: const Color.fromRGBO(30, 30, 30, 1)),
            hintText: hintText,
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
