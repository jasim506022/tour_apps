import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../const/const.dart';
import '../model/placemodel.dart';
import '../model/tripsmodel.dart';
import '../page/home/itemdetailspage.dart';

class TopTripsWidget extends StatelessWidget {
  const TopTripsWidget({
    super.key,
    required this.tourPlaceDetailsModel,
    required this.selectedCategories,
  });
  final TourPlaceDetailsModel tourPlaceDetailsModel;
  final String selectedCategories;
  @override
  Widget build(BuildContext context) {
    if (tourPlaceDetailsModel.categories == selectedCategories) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ItemDetailsPage(model: tourPlaceDetailsModel),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            height: 180,
            width: 165,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FancyShimmerImage(
                    imageUrl: tourPlaceDetailsModel.image[0],
                    height: 110,
                    boxFit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      tourPlaceDetailsModel.tourplace,
                      overflow: TextOverflow.ellipsis,
                      style:
                          categoryTitle.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: yello,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          tourPlaceDetailsModel.rate.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: unselectedColor),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.location_sharp,
                      size: 12,
                      color: unselectedColor,
                    ),
                    Text(tourPlaceDetailsModel.location,
                        style: textStyle.copyWith(fontSize: 11)),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "\$ ${tourPlaceDetailsModel.cost} ",
                            style: tourplacetextSTyle,
                          ),
                          TextSpan(
                              text: "/Visit",
                              style: tourplacetextSTyle.copyWith(color: black))
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Ionicons.heart,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }
}

class TripsWidget extends StatelessWidget {
  const TripsWidget({
    super.key,
    required this.tripsModel,
  });
  final TripsModel tripsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          height: 250,
          width: 165,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FancyShimmerImage(
                  imageUrl: tripsModel.tripimage![0],
                  height: 110,
                  boxFit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    tripsModel.tripsname!,
                    overflow: TextOverflow.ellipsis,
                    style: categoryTitle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: yello,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        tripsModel.tripsrate!,
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: unselectedColor),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.location_sharp,
                    size: 12,
                    color: unselectedColor,
                  ),
                  Text(tripsModel.triplocation!,
                      style: textStyle.copyWith(fontSize: 11)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "\$ ${tripsModel.tripcost!} ",
                          style: tourplacetextSTyle,
                        ),
                        TextSpan(
                            text: "/Visit",
                            style: tourplacetextSTyle.copyWith(color: black))
                      ],
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Ionicons.heart,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
