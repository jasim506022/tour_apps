import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tour_apps/const/const.dart';

import '../model/grouptipmodel.dart';

class GroupTips extends StatelessWidget {
  const GroupTips({
    super.key,
    required this.groupTipsModel,
  });

  final GroupTipsModel groupTipsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FancyShimmerImage(
                imageUrl: groupTipsModel.image[0],
                height: 120,
                boxFit: BoxFit.fill,
                width: 140,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    groupTipsModel.tourplace,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(30, 30, 30, 1)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    groupTipsModel.location,
                    style: textStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.location_sharp,
                        size: 12,
                        color: unselectedColor,
                      ),
                      Text(
                        groupTipsModel.location,
                        style: textStyle.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Text(
                            "${groupTipsModel.progressNumber * 100}%",
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      LinearPercentIndicator(
                        width: 200,
                        animation: true,
                        lineHeight: 10.0,
                        animationDuration: 2500,
                        percent: groupTipsModel.progressNumber,
                        // center: const Text("80.0%"),
                        barRadius: const Radius.circular(30),
                        progressColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupTripsWidget extends StatelessWidget {
  const GroupTripsWidget({
    super.key,
    required this.groupTipsModel,
  });

  final GroupTipsModelFirebase groupTipsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FancyShimmerImage(
                imageUrl: groupTipsModel.tripimage![0],
                height: 120,
                boxFit: BoxFit.fill,
                width: 140,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    groupTipsModel.tripsname!,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(30, 30, 30, 1)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    groupTipsModel.triplocation!,
                    style: textStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.location_sharp,
                        size: 12,
                        color: unselectedColor,
                      ),
                      Text(
                        groupTipsModel.triplocation!,
                        style: textStyle.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Text(
                            "${double.parse(groupTipsModel.tripsrate!) * 100}%",
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      LinearPercentIndicator(
                        width: 200,
                        animation: true,
                        lineHeight: 10.0,
                        animationDuration: 2500,
                        percent: double.parse(groupTipsModel.tripsrate!),
                        // center: const Text("80.0%"),
                        barRadius: const Radius.circular(30),
                        progressColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
