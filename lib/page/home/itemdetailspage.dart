import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour_apps/const/const.dart';

import '../../admin/widget/singletourwidget.dart';
import '../../model/placemodel.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key, required this.model});

  final TourPlaceDetailsModel model;

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  void initState() {
    image = widget.model.image[0];
    super.initState();
  }

  String? image;
  
  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "${widget.model.categories} View",
        ),
        actions: [
          PopupMenuButton(onSelected: (value) {
            // your logic
            setState(() {
              selectedItem = value.toString();
            });
            print(value);
            Navigator.pushNamed(context, value.toString());
          }, itemBuilder: (BuildContext bc) {
            return const [
              PopupMenuItem(
                child: Text("Hello"),
                value: '/hello',
              ),
              PopupMenuItem(
                child: Text("About"),
                value: '/about',
              ),
              PopupMenuItem(
                child: Text("Contact"),
                value: '/contact',
              )
            ];
          })
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FancyShimmerImage(
                          imageUrl: image!,
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
                          itemCount: widget.model.image.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    image = widget.model.image[index];
                                  });
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            widget.model.image[index]),
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
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(widget.model.tourplace,
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
                    widget.model.location,
                    style: textStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.model.description,
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
                      child: Text("Booking Now | \$ ${widget.model.cost}",
                          textAlign: TextAlign.justify,
                          style: appbarTextStyle.copyWith(color: white)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Ionicons.heart,
                    color: Color.fromRGBO(175, 175, 175, 1),
                    size: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
