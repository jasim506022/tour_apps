import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/placemodel.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  String image = tourplacedetaillist[0].image[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 1),
        title: Text(
          "Items View",
          style: GoogleFonts.inter(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(50, 50, 50, 1)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .5,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(image,
                      height: MediaQuery.of(context).size.height * .5,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 20,
                  child: SizedBox(
                    height: 80,
                    width: 250,
                    child: ListView.builder(
                      itemCount: tourplacedetaillist[0].image.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                image = tourplacedetaillist[0].image[index];
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        tourplacedetaillist[0].image[index]),
                                    fit: BoxFit.fill,
                                  ),
                                  border: Border.all(
                                      color: Colors.white, width: 5)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                tourplacedetaillist[0].tourplace,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                    fontSize: 20,
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
                    size: 22,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    tourplacedetaillist[0].rate.toString(),
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(99, 99, 99, 1)),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
