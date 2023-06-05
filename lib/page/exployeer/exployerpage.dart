import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/model/placemodel.dart';

import 'exployeerpagedetails.dart';

class ExployeerPage extends StatefulWidget {
  const ExployeerPage({super.key});

  @override
  State<ExployeerPage> createState() => ExployeerPageState();
}

class ExployeerPageState extends State<ExployeerPage> {
  
  @override
  void initState() {
    super.initState();
  }

  GoogleMapController? googleMapController;

  final LatLng center = const LatLng(21.4272, 92.0058);

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Explore",
                      style: appbarTextStyle.copyWith(fontSize: 36)),
                  const Spacer(),
                  const Icon(
                    Icons.notifications,
                    size: 25,
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .57,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FancyShimmerImage(
                        imageUrl: tourplacedetaillist[0].image[index],
                        boxFit: BoxFit.fill,
                      ),
                    );
                  },
                  autoplay: true,
                  duration: 20,
                  itemCount: tourplacedetaillist[0].image.length,
                  layout: SwiperLayout.DEFAULT,
                  pagination: const SwiperPagination(
                      builder:
                          DotSwiperPaginationBuilder(activeColor: Colors.red)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .35,
                  child: GoogleMap(
                    onMapCreated: onMapCreated,
                    initialCameraPosition:
                        CameraPosition(target: center, zoom: 11.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: FloatingActionButton.extended(
            backgroundColor: blueColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExployeePageDetails(),
                  ));
            },
            label: Text(
              "Start",
              style: appbarTextStyle.copyWith(color: Colors.white),
            ),
            icon: const Icon(Ionicons.airplane),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
