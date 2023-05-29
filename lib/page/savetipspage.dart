import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class SaveTipsPage extends StatefulWidget {
  const SaveTipsPage({super.key});

  @override
  State<SaveTipsPage> createState() => _SaveTipsPageState();
}

class _SaveTipsPageState extends State<SaveTipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 1),
        title: Text(
          "Saved Trips",
          style: GoogleFonts.inter(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(50, 50, 50, 1)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Events",
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(50, 50, 50, 1)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "asset/categories/sea/kua/kua1.jpeg",
                              height: 120,
                              fit: BoxFit.fill,
                              width: 140,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Mountain Trip",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(30, 30, 30, 1)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Seelisburg",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(99, 99, 99, 1)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Ionicons.location_sharp,
                                      size: 12,
                                      color: Color.fromRGBO(99, 99, 99, 1),
                                    ),
                                    Text(
                                      "Dhaka",
                                      style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(99, 99, 99, 1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Icon(
                          //       Ionicons.location_sharp,
                          //       size: 12,
                          //       color: Color.fromRGBO(99, 99, 99, 1),
                          //     ),
                          //     Text(
                          //       "tourplacedetaillist[index].location",
                          //       style: GoogleFonts.inter(
                          //           fontSize: 11,
                          //           fontStyle: FontStyle.normal,
                          //           fontWeight: FontWeight.w400,
                          //           color: Color.fromRGBO(99, 99, 99, 1)),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // Row(
                          //   children: [
                          //     RichText(
                          //       text: TextSpan(
                          //         children: [
                          //           TextSpan(
                          //             text: "\$ ",
                          //             style: GoogleFonts.inter(
                          //               fontSize: 12,
                          //               fontStyle: FontStyle.normal,
                          //               fontWeight: FontWeight.w400,
                          //               color: Color.fromRGBO(0, 143, 160, 1),
                          //             ),
                          //           ),
                          //           TextSpan(
                          //             text: "/Visit",
                          //             style: GoogleFonts.inter(
                          //               fontSize: 12,
                          //               fontStyle: FontStyle.normal,
                          //               fontWeight: FontWeight.w400,
                          //               color: Color.fromRGBO(30, 30, 30, 1),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     Spacer(),
                          //     Icon(
                          //       Icons.heart_broken,
                          //       color: Color.fromRGBO(0, 143, 160, 1),
                          //       size: 20,
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Package",
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(50, 50, 50, 1)),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "asset/categories/sea/kua/kua1.jpeg",
                              height: 120,
                              fit: BoxFit.fill,
                              width: 140,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Mountain Trip",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(30, 30, 30, 1)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Seelisburg",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(99, 99, 99, 1)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Ionicons.location_sharp,
                                      size: 12,
                                      color: Color.fromRGBO(99, 99, 99, 1),
                                    ),
                                    Text(
                                      "Dhaka",
                                      style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(99, 99, 99, 1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Icon(
                          //       Ionicons.location_sharp,
                          //       size: 12,
                          //       color: Color.fromRGBO(99, 99, 99, 1),
                          //     ),
                          //     Text(
                          //       "tourplacedetaillist[index].location",
                          //       style: GoogleFonts.inter(
                          //           fontSize: 11,
                          //           fontStyle: FontStyle.normal,
                          //           fontWeight: FontWeight.w400,
                          //           color: Color.fromRGBO(99, 99, 99, 1)),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // Row(
                          //   children: [
                          //     RichText(
                          //       text: TextSpan(
                          //         children: [
                          //           TextSpan(
                          //             text: "\$ ",
                          //             style: GoogleFonts.inter(
                          //               fontSize: 12,
                          //               fontStyle: FontStyle.normal,
                          //               fontWeight: FontWeight.w400,
                          //               color: Color.fromRGBO(0, 143, 160, 1),
                          //             ),
                          //           ),
                          //           TextSpan(
                          //             text: "/Visit",
                          //             style: GoogleFonts.inter(
                          //               fontSize: 12,
                          //               fontStyle: FontStyle.normal,
                          //               fontWeight: FontWeight.w400,
                          //               color: Color.fromRGBO(30, 30, 30, 1),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     Spacer(),
                          //     Icon(
                          //       Icons.heart_broken,
                          //       color: Color.fromRGBO(0, 143, 160, 1),
                          //       size: 20,
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
