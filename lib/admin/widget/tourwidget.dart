import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/model/tripsmodel.dart';

import '../home/tourdetailsadmin.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class TourWidget extends StatefulWidget {
  const TourWidget({
    Key? key,
    required this.tripsModel,
  }) : super(key: key);

  final TripsModels tripsModel;

  @override
  State<TourWidget> createState() => _TourWidgetState();
}

class _TourWidgetState extends State<TourWidget> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TourDetailsAdmin(model: widget.tripsModel),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          height: 110,
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
                  imageUrl: widget.tripsModel.image![0],
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
                            widget.tripsModel.tourname!,
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
                                widget.tripsModel.rate.toString(),
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
                                color: blueColor,
                              ),
                              Text(
                                widget.tripsModel.location!,
                                style: textStyle.copyWith(
                                    fontSize: 11, color: blueColor),
                              ),
                            ],
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                text: "Cateogry :",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              TextSpan(
                                  text: "  ${widget.tripsModel.categoris}",
                                  style: textStyle.copyWith(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),

                          // Icon(
                          //   Ionicons.heart,
                          //   color: Theme.of(context).primaryColor,
                          //   size: 30,
                          // )
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Tk ${widget.tripsModel.cost} /",
                            style: textStyle.copyWith(
                                fontSize: 13,
                                color: black,
                                fontWeight: FontWeight.w900),
                          ),
                          const TextSpan(
                              text: "per person",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ))
                        ]),
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
