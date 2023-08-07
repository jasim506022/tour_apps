import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/const/const.dart';
import '../../model/tourmodel.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../service/provider/admin/imageselectprovider.dart';

class TourDetails extends StatefulWidget {
  const TourDetails({
    super.key,
    required this.model,
  });

  final TourModel model;

  @override
  State<TourDetails> createState() => _TourDetailsState();
}

class _TourDetailsState extends State<TourDetails> {
  List<String> itemsIDsList = prefs!.getStringList("savetour")!;

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: Colors.white),
    // );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(
            "${widget.model.tourname} View",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                if (itemsIDsList.contains(widget.model.id)) {
                  DocumentSnapshot userSnapshot = await FirebaseFirestore
                      .instance
                      .collection("users")
                      .doc(prefs!.getString("uid"))
                      .get();

                  List<dynamic> savetour = userSnapshot.get("savetour");
                  savetour.remove(widget.model.id);

                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(prefs!.getString("uid"))
                      .update({"savetour": savetour});
                  List<String> stringList = savetour
                      .map((dynamic element) => element.toString())
                      .toList();
                  await prefs!.setStringList("savetour", stringList);
                  itemsIDsList = prefs!.getStringList("savetour")!;
                  setState(() {});
                } else {
                  List<String> tempList = prefs!.getStringList("savetour")!;
                  tempList.add(widget.model.id!);
                  // await prefs!.setStringList("userCart", tempList); //2367121:5
                  //save to firestore database
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(prefs!.getString("uid"))
                      .update({
                    "savetour": tempList,
                  }).then((value) async {
                    await prefs!.setStringList("savetour", tempList);
                    itemsIDsList = prefs!.getStringList("savetour")!;
                    setState(() {});
                    Fluttertoast.showToast(msg: "Item added successfully.");
                  });
                }
              },
              icon: Icon(
                Ionicons.heart,
                color: itemsIDsList.contains(widget.model.id)
                    ? Colors.red
                    : Color.fromRGBO(175, 175, 175, 1),
                size: 40,
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<ImageSelectProvider>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FancyShimmerImage(
                              imageUrl: widget.model.image![value.selectImage],
                              height: MediaQuery.of(context).size.height * .5,
                              boxFit: BoxFit.fill,
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
                              itemCount: widget.model.image!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<ImageSelectProvider>(context,
                                              listen: false)
                                          .setImage(imageNumber: index);
                                      Provider.of<ImageSelectProvider>(context,
                                              listen: false)
                                          .setColor(colorNumber: index);
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                widget.model.image![index]),
                                            fit: BoxFit.fill,
                                          ),
                                          border: Border.all(
                                              color: value.selectColor == index
                                                  ? Colors.red
                                                  : Colors.white,
                                              width: 5)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(widget.model.tourname!,
                      overflow: TextOverflow.ellipsis,
                      style: appbarTextStyle.copyWith(fontSize: 22)),
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
                      Text(widget.model.rate.toString(),
                          style: textStyle.copyWith(fontSize: 18)),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.location_sharp,
                    size: 18,
                    color: unselectedColor,
                  ),
                  Text(
                    widget.model.location!,
                    style: textStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('yyyy-MM-dd HH:mm:ss')
                      .format(widget.model.tourdate!.toDate()),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.model.description!,
                textAlign: TextAlign.justify,
                style: textStyle.copyWith(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color.fromRGBO(233, 233, 233, 1),
                        width: 1)),
                child: Text("Booking Now| \$ ${widget.model.cost}",
                    textAlign: TextAlign.justify,
                    style: appbarTextStyle.copyWith(color: white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
