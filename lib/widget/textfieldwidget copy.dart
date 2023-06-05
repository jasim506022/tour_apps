import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFormFieldWidgetWithLable extends StatelessWidget {
  TextFormFieldWidgetWithLable(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.obscureText = false,
      required this.validatorText,
      required this.labelttext});

  final TextEditingController controller;
  IconData icon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  final String labelttext;

  final String hintText;
  int? maxLines;
  final String validatorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return validatorText;
            }
          },
          
          maxLines: maxLines,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
          
            label: Text(labelttext),
            prefixIcon: maxLines == 5
                ? Icon(
                    icon,
                    color: Colors.white,
                  )
                : Icon(
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
