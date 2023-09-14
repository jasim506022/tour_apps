import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Circular progress bar
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "$message , Please Wait......",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
