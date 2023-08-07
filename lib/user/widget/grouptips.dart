import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/const/const.dart';

import '../../admin/group/gruptourdetailseadmin.dart';
import '../../model/grouptipmodel.dart';

class GroupTourWidget extends StatelessWidget {
  const GroupTourWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final grouptourModel = Provider.of<GroupTourModel>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  GroupTourDetailsScreen(model: grouptourModel),
            ));
      },
      child: Padding(
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
                  imageUrl: grouptourModel.image![0],
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
                    Row(
                      children: [
                        Text(
                          grouptourModel.tourname!,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(30, 30, 30, 1)),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: yello,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "4.5",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  color: unselectedColor),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Ionicons.location_sharp,
                              size: 12,
                              color: blueColor,
                            ),
                            Text(
                              grouptourModel.location!,
                              style: textStyle.copyWith(
                                  fontSize: 11, color: blueColor),
                            ),
                          ],
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Duration :",
                              style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(30, 30, 30, 1)),
                            ),
                            TextSpan(
                                text: " ${grouptourModel.duration!}",
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor))
                          ]),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Tk ${grouptourModel.cost!} /",
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: black)
                            // style: textStyle.copyWith(
                            //     fontSize: 13,
                            //     color: black,
                            //     fontWeight: FontWeight.w900),
                            ),
                        TextSpan(
                            text: "4 Persons",
                            style: GoogleFonts.inter(
                                fontSize: 11, color: Colors.grey)

                            // style: TextStyle(
                            //   color: Colors.grey,
                            //   fontSize: 11,
                            // )
                            )
                      ]),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sit Booking:  ",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color: black),
                                  ),
                                  Text(
                                    "${(grouptourModel.bookingsit!) * 100}%",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              LinearPercentIndicator(
                                width: 110,
                                animation: true,
                                lineHeight: 10.0,
                                animationDuration: 2500,
                                percent: (grouptourModel.bookingsit!),
                                barRadius: const Radius.circular(30),
                                progressColor: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
