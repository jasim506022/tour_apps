import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../../const/const.dart';
import '../../model/grouptipmodel.dart';
import '../../model/placemodel.dart';
import '../../widget/alltripswidget.dart';
import '../../widget/grouptips.dart';

class SaveTipsPage extends StatefulWidget {
  const SaveTipsPage({super.key});

  @override
  State<SaveTipsPage> createState() => _SaveTipsPageState();
}

class _SaveTipsPageState extends State<SaveTipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        title: Text(
          "Saved Trips",
          style: GoogleFonts.inter(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(50, 50, 50, 1)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Events",
                style: appbarTextStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .45,
                child: ListView.builder(
                  itemCount: tourplacedetaillist.length,
                  itemBuilder: (context, index) {
                    return AllTripsWidget(
                      tourPlaceDetailsModel: tourplacedetaillist[index],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Package", style: appbarTextStyle),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: grouptipsdetaillist.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GroupTips(
                      groupTipsModel: grouptipsdetaillist[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
