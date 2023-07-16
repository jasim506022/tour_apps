import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/admin/adminmainpage.dart';
import 'package:tour_apps/admin/home/uploadscreen.dart';
import 'package:tour_apps/admin/services/provider/imageselectprovider.dart';
import 'package:tour_apps/const/const.dart';
import '../../model/tourmodel.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TourDetailsAdmin extends StatefulWidget {
  const TourDetailsAdmin({
    super.key,
    required this.model,
  });

  final TourModel model;

  @override
  State<TourDetailsAdmin> createState() => _TourDetailsAdminState();
}

class _TourDetailsAdminState extends State<TourDetailsAdmin> {
  @override
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "${widget.model.tourname} View",
        ),
        centerTitle: true,
        actions: [
          Consumer<ImageSelectProvider>(
            builder: (context, values, child) {
              return PopupMenuButton(onSelected: (value) {
                values.setMenu(setMenu: value);
                if (values.getMenu == DeleteUpdate.delete) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Are you want to Delete!"),
                        content: const Text(
                            "Do you want delete this tour Permanently"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cencel")),
                          TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("trip")
                                    .doc(widget.model.id)
                                    .delete();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => AdminMainPage()));
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.red),
                              )),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadScreen(
                          isUPdate: true,
                          tripsModels: widget.model,
                        ),
                      ));
                }
              }, itemBuilder: (BuildContext bc) {
                return [
                  const PopupMenuItem(
                    value: DeleteUpdate.delete,
                    child: Text("Delete"),
                  ),
                  const PopupMenuItem(
                    value: DeleteUpdate.update,
                    child: Text("Update"),
                  ),
                ];
              });
            },
          )
        ],
      ),
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color.fromRGBO(233, 233, 233, 1),
                              width: 1)),
                      child: Text("Per Person | \$ ${widget.model.cost}",
                          textAlign: TextAlign.justify,
                          style: appbarTextStyle.copyWith(color: white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
