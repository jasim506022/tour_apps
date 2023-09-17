import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';

import '../../others/const.dart';
import '../../model/profiledatamodel.dart';
import '../adminmainpage.dart';

class BlockUnBlockWidget extends StatelessWidget {
  const BlockUnBlockWidget({
    super.key,
    required this.profileModel,
  });

  final ProfileDataModel profileModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: profileModel.status == "approved"
          ? Text(
              "Are you Want to block This User",
              style: GoogleFonts.inter(
                fontSize: 13,
                letterSpacing: 1.2,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).hintColor,
              ),
            )
          : Text(
              "Are you Want to UnBlock This User",
              style: GoogleFonts.inter(
                fontSize: 13,
                letterSpacing: 1.2,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).hintColor,
              ),
            ),
      content: profileModel.status == "approved"
          ? Text(
              "If You want to block this account please click Yes",
              style: GoogleFonts.inter(
                fontSize: 12,
                letterSpacing: 1,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor,
              ),
            )
          : Text(
              "If You want to Unblock this account please click Yes",
              style: GoogleFonts.inter(
                fontSize: 12,
                letterSpacing: 1,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor,
              ),
            ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cencel")),
        TextButton(
            onPressed: () async {
              if (profileModel.status == "approved") {
                await FirebaseServices.updateData(
                    collection: "users",
                    id: profileModel.uid!,
                    map: ({"status": "Not Approved"})).then((value) {
                  showToast(context: context, text: "Block Successfully");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminMainPage(index: 2),
                      ));
                });
              } else {
                await FirebaseServices.updateData(
                    collection: "users",
                    id: profileModel.uid!,
                    map: ({"status": "Not approved"})).then((value) {
                  showToast(context: context, text: "Unblock Successfully");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminMainPage(index: 2),
                      ));
                });
              }
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
