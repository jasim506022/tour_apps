import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.text, required this.funtion,
  });
  final String text;
  final VoidCallback funtion;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(30, 30, 30, 1)),
        ),
        const Spacer(),
        InkWell(
          onTap: funtion,
          child: Text(
            "See All",
            style: GoogleFonts.inter(
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(162, 162, 162, 1)),
          ),
        ),
      ],
    );
  }
}
