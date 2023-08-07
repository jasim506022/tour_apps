import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import '../../const/const.dart';
import '../../model/tourmodel.dart';
import '../tourpage/tourdetailspage.dart';

// ignore: must_be_immutable
class TopTourWidget extends StatelessWidget {
  TopTourWidget({
    super.key,
    required this.tourModel,
    required this.selectedCategories,
  });
  final TourModel tourModel;
  final String selectedCategories;

  List<String> itemsIDsList = prefs!.getStringList("savetour")!;
  @override
  Widget build(BuildContext context) {
    if (tourModel.categoris == selectedCategories) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TourDetails(
                  model: tourModel,
                ),
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
                    imageUrl: tourModel.image![0],
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
                      tourModel.tourname!,
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
                          tourModel.rate.toString(),
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
                    Text(tourModel.location!,
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
                            text: "\$ ${tourModel.cost} ",
                            style: tourplacetextSTyle,
                          ),
                          TextSpan(
                              text: "/Visit",
                              style: tourplacetextSTyle.copyWith(color: black))
                        ],
                      ),
                    ),
                    const Spacer(),
                    itemsIDsList.contains(tourModel.id)
                        ? Icon(
                            Ionicons.heart,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          )
                        : Icon(
                            Ionicons.heart_outline,
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
