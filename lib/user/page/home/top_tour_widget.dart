import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import '../../../others/const.dart';
import '../../../others/globalcolor.dart';
import '../../../others/textstyle.dart';
import '../../../model/tourmodel.dart';
import '../tourpage/tourdetailspage.dart';

// ignore: must_be_immutable
class TopTourWidget extends StatelessWidget {
  TopTourWidget({
    super.key,
    required this.tourModel,
  });
  final TourModel tourModel;

  List<String> singletouritem = prefs!.getStringList("savetour")!;
  @override
  Widget build(BuildContext context) {
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
            //change
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 4)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FancyShimmerImage(
                    imageUrl: tourModel.image![0],
                    height: 100,
                    boxFit: BoxFit.fill,
                    width: double.infinity,
                  ),
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
                    style: GoogleFonts.inter(
                      //change
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: yelloColor,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        tourModel.rate.toString(),
                        style: smallesttextStyle.copyWith(
                            color: Theme.of(context).hintColor),
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
                  Icon(Ionicons.location_sharp,
                      size: 12, color: Theme.of(context).iconTheme.color),
                  Text(tourModel.location!,
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor))
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
                            style: smallTextStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: "/Visit",
                            style: smallTextStyle.copyWith(
                                color: Theme.of(context).hintColor))
                      ],
                    ),
                  ),
                  const Spacer(),
                  singletouritem.contains(tourModel.id)
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
}
