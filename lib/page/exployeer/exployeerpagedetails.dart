import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/model/placemodel.dart';

class ExployeePageDetails extends StatelessWidget {
  const ExployeePageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(tourplacedetaillist[0].image[0]),
                  fit: BoxFit.fill),
            ),
          ),
          Positioned(
            top: 30,
            left: 25,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.4),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          tourplacedetaillist[0].image[1],
                          height: 180,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            tourplacedetaillist[0].tourplace,
                            overflow: TextOverflow.ellipsis,
                            style: textStylemontserrat.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: yello,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(tourplacedetaillist[0].rate.toString(),
                                  style: textStylemontserrat.copyWith(
                                      fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                          "One of EATER National and Atlanta Magazine’s most anticipated new openings of 2013.This new restaurant by Ford Fry and Rocket Farm, designed by Meyer Davis and NO Architecture, is located at the corner of West Paces Ferry,",
                          textAlign: TextAlign.justify,
                          style: textStylemontserrat.copyWith(fontSize: 11)),
                      const Spacer(),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://cdn.pixabay.com/photo/2016/05/19/17/11/woman-1403458_640.jpg"),
                            radius: 18,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Miley Erikson",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.circle,
                            color: unselectedColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text("2 weeks ago",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  textStylemontserrat.copyWith(fontSize: 10)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
