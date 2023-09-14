import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_apps/others/const.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';

import '../adminmainpage.dart';

class DeleteTour extends StatelessWidget {
  const DeleteTour({
    super.key,
    required this.id,
    required this.collection,
  });

  final String id;
  final String collection;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          Text(
            "Are you want to Delete!",
            style: GoogleFonts.yesevaOne(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).hintColor),
          ),
        ],
      ),
      content: Text("Do you want delete this tour Permanently",
          style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).hintColor)),
      backgroundColor: Theme.of(context).cardColor,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cencel")),
        TextButton(
            onPressed: () {
              FirebaseServices.deleteTour(
                id: id,
                collection: collection,
              ).then((value) {
                showToast(context: context, text: "Delete Sucessfully");
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => AdminMainPage()));
              });
            },
            child: Text(
              "Yes",
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
            )),
      ],
    );
  }
}
