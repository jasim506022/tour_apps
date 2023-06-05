import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import 'package:tour_apps/widget/grouptips.dart';

import '../../model/placemodel.dart';
import '../../widget/alltripswidget.dart';

class AllTripsPage extends StatefulWidget {
  AllTripsPage({super.key, this.isGroup = false});

  bool? isGroup;

  @override
  State<AllTripsPage> createState() => _AllTripsPageState();
}

class _AllTripsPageState extends State<AllTripsPage> {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          widget.isGroup == true ? " All Groups Trips" : "All Trips",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
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
              height: 15,
            ),
            Expanded(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: widget.isGroup == true
                        ? grouptipsdetaillist.length
                        : tourplacedetaillist.length,
                    //shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (widget.isGroup!) {
                        return GroupTips(
                            groupTipsModel: grouptipsdetaillist[index]);
                      }
                      return AllTripsWidget(
                        tourPlaceDetailsModel: tourplacedetaillist[index],
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
