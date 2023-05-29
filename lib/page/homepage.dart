import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../model/categoriesmodel.dart';
import '../model/grouptipmodel.dart';
import '../model/placemodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectCategoris = 0;
  String categoryString = "Sea";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(247, 247, 247, 1),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Location",
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(99, 99, 99, 1)),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Ionicons.location_sharp,
                    size: 25,
                    color: Color.fromRGBO(61, 61, 61, 1),
                  ),
                  Text(
                    "Dhaka, Bangladesh",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(50, 50, 50, 1)),
                  ),
                  const Icon(
                    IconlyLight.arrowDown2,
                    size: 25,
                    color: Color.fromRGBO(255, 210, 51, 1),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            prefixIcon: const Icon(Icons.search,
                                color: Color.fromRGBO(99, 99, 99, 1)),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color(0xffAFAFAF), width: 1))),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xff008FA0),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "asset/image/slider.png",
                        height: 25,
                        width: 25,
                        fit: BoxFit.fill,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const RowWidget(
                text: 'Category',
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectCategoris = index;
                            categoryString = categories[index].name;
                            print(categoryString);
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xff008FA0), width: 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectCategoris == index
                                      ? const Color(0xff008FA0)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                //padding: EdgeInsets.all(6),
                                child: Image.asset(
                                  categories[index].imagename,
                                  height: 24,
                                  width: 24,
                                  color: selectCategoris == index
                                      ? Colors.white
                                      : const Color(0xff008FA0),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  categories[index].name,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          const Color.fromRGBO(30, 30, 30, 1)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const RowWidget(
                text: 'Top Trips',
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: tourplacedetaillist.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TopTripsWidget(
                        tourPlaceDetailsModel: tourplacedetaillist[index],
                        selectedCategories: categoryString,
                      );
                    },
                  )),
              const SizedBox(
                height: 5,
              ),
              const RowWidget(
                text: 'Group Trips',
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: grouptipsdetaillist.length,
                    //  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GroupTips(groupTipsModel: grouptipsdetaillist[index],);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupTips extends StatelessWidget {
  const GroupTips({
    super.key, required this.groupTipsModel,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
               groupTipsModel.image[0],
                height: 120,
                fit: BoxFit.fill,
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
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(99, 99, 99, 1)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Ionicons.location_sharp,
                        size: 12,
                        color: Color.fromRGBO(99, 99, 99, 1),
                      ),
                      Text(
                        groupTipsModel.location,
                        style: GoogleFonts.inter(
                            fontSize: 11,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(99, 99, 99, 1)),
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
                           "${groupTipsModel.progressNumber*100}%",
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 143, 160, 1)),
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
                        progressColor: const Color.fromRGBO(0, 143, 160, 1),
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
      return Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          height: 180,
          width: 165,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  tourPlaceDetailsModel.image[0],
                  height: 110,
                  fit: BoxFit.fill,
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
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(30, 30, 30, 1)),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromRGBO(225, 216, 0, 1),
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
                            color: const Color.fromRGBO(99, 99, 99, 1)),
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
                  const Icon(
                    Ionicons.location_sharp,
                    size: 12,
                    color: Color.fromRGBO(99, 99, 99, 1),
                  ),
                  Text(
                    tourPlaceDetailsModel.location,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(99, 99, 99, 1)),
                  ),
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
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 143, 160, 1),
                          ),
                        ),
                        TextSpan(
                          text: "/Visit",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(30, 30, 30, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.heart_broken,
                    color: Color.fromRGBO(0, 143, 160, 1),
                    size: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(30, 30, 30, 1)),
        ),
        const Spacer(),
        Text(
          "See All",
          style: GoogleFonts.inter(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(162, 162, 162, 1)),
        ),
      ],
    );
  }
}
