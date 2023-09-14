import 'dart:async';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/others/globalcolor.dart';
import 'package:tour_apps/others/textstyle.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import 'numberuserbooktour.dart';

class BookingGroupWidgetAdmin extends StatefulWidget {
  const BookingGroupWidgetAdmin({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final List<dynamic> uid;
  @override
  State<BookingGroupWidgetAdmin> createState() =>
      _BookingGroupWidgetAdminState();
}

class _BookingGroupWidgetAdminState extends State<BookingGroupWidgetAdmin> {
  String? dateTime;

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var myData = Provider.of<GroupTourModel>(context, listen: false);
      DateTime currentTime = DateTime.now();
      DateTime otherTime = myData.tourdate!.toDate();

      Duration difference = currentTime.difference(otherTime);
      Duration time = difference.abs();

      setState(() {
        dateTime =
            'Time Left: ${time.inDays} days, ${time.inHours % 24} hours, and ${time.inMinutes % 60} minutes ${time.inSeconds % 60} seconds';
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tourmodel = Provider.of<GroupTourModel>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NumberOfUserBookingPage(
                  uid: widget.uid,
                  tourName: tourmodel.tourname!,
                  ids: tourmodel.id!),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          height: 110,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FancyShimmerImage(
                  imageUrl: tourmodel.image![0],
                  height: 95,
                  boxFit: BoxFit.fill,
                  width: 140,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            tourmodel.tourname!,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).hintColor),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: yelloColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                tourmodel.rate.toString(),
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).hintColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.location_sharp,
                                size: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                tourmodel.location!,
                                style: smallTextStyle.copyWith(
                                    fontSize: 11,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Cateogry :",
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        dateTime ?? "",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
