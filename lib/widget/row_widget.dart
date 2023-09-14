import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../others/textstyle.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.text,
    required this.funtion,
  });
  final String text;
  final VoidCallback funtion;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.secondary),
        ),
        const Spacer(),
        InkWell(
          onTap: funtion,
          child: Text(
            "See All",
            style: mediumTextStyle.copyWith(color: Theme.of(context).hintColor),
          ),
        ),
      ],
    );
  }
}
