import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.function,
  });

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 1)),
        child: Text("Search Here",
            style: GoogleFonts.inter(
                fontSize: 12,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600)),
      ),
    );
  }
}
