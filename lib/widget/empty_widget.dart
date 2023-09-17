
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        Image.asset(image),
        Positioned(
          left: 90,
          right: 20,
          top: 30,
          bottom: 0,
          child: Text(text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 22,
                color: const Color.fromARGB(255, 255, 19, 2),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
              )),
        ),
      ],
    ));
  }
}
