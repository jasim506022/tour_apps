import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour_apps/page/home/alltripspage.dart';
import '../../const/const.dart';
import '../../model/categoriesmodel.dart';
import '../../model/grouptipmodel.dart';
import '../../model/placemodel.dart';
import '../../widget/grouptips.dart';
import '../../widget/rowwidget.dart';
import '../../widget/toptripswidget.dart';
import 'fortext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double latitude = 0.0;
  double longitude = 0.0;

  int selectCategoris = 0;
  String categoryString = "Sea";

  String address = "";
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    getAddres();
    super.initState();
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      showToast(context: context, text: "Location permissions are denied");
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  getAddres() async {
    List<Placemark>? placemarks =
        await placemarkFromCoordinates(52.2165157, 6.9437819);
    Placemark placemark = placemarks[0];
    address = placemark.country!;
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("location"),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.location_sharp,
                    size: 25,
                    color: iconColor,
                  ),
                  const LocationPage(),
                  Icon(
                    IconlyLight.arrowDown2,
                    size: 25,
                    color: yello,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.notifications,
                    color: iconColor,
                  )
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
                            prefixIcon:
                                Icon(Icons.search, color: unselectedColor),
                            fillColor: white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: unselectedColor, width: 1))),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "asset/image/slider.png",
                        height: 25,
                        width: 25,
                        fit: BoxFit.fill,
                        color: white,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RowWidget(
                text: 'Category',
                funtion: () {},
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
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectCategoris == index
                                      ? Theme.of(context).primaryColor
                                      : white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(categories[index].imagename,
                                    height: 24,
                                    width: 24,
                                    color: selectCategoris == index
                                        ? white
                                        : Theme.of(context).primaryColor),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  categories[index].name,
                                  style: categoryTitle,
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
              RowWidget(
                text: 'Top Trips',
                funtion: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllTripsPage(),
                      ));
                },
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
              RowWidget(
                text: 'Group Trips',
                funtion: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllTripsPage(
                          isGroup: true,
                        ),
                      ));
                },
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: grouptipsdetaillist.length,
                    //  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GroupTips(
                        groupTipsModel: grouptipsdetaillist[index],
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
