import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour_apps/const/const.dart';

import '../../model/tourmodel.dart';

class AllTripsWidget extends StatelessWidget {
  const AllTripsWidget({
    super.key,
    required this.tourPlaceDetailsModel,
  });

  final TourModel tourPlaceDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: 120,
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
                imageUrl: tourPlaceDetailsModel.image![0],
                height: 105,
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
                          tourPlaceDetailsModel.tourname!,
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
                              tourPlaceDetailsModel.rate.toString(),
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
                              tourPlaceDetailsModel.location!,
                              style: textStyle.copyWith(
                                  fontSize: 11, color: blueColor),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Icon(
                          Ionicons.heart,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Cateogry: ${tourPlaceDetailsModel.location}",
                      style: textStyle.copyWith(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${tourPlaceDetailsModel.cost} Tk",
                      style: textStyle.copyWith(
                          fontSize: 18,
                          color: blueColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
