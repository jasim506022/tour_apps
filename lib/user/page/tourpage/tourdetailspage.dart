import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/others/const.dart';
import 'package:tour_apps/others/globalcolor.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import 'package:tour_apps/service/provider/details_provider.dart';
import 'package:tour_apps/service/provider/loading_provider.dart';
import '../../../widget/change_image_silder_widget.dart';
import '../../../others/textstyle.dart';
import '../../../model/tourmodel.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../mainpage.dart';
import '../../../service/other/pushnotificationmessage.dart';

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
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<DetailsProvider>(context, listen: false)
          .setImage(imageNumber: 0);
    });
    super.initState();
  }

  String bookingid = DateTime.now().millisecondsSinceEpoch.toString();
  PushNotificationMessage pushNotificationMessage = PushNotificationMessage();

  List<dynamic> itemList = [];

  List<String> saveItemList = prefs!.getStringList("savetour") ?? ["0"];
  List<String> itembookinglist = prefs!.getStringList("bookingtour") ?? ["0"];

  Future<void> paymentCheckout(double amount, String id, String token,
      String title, String body, String userid) async {
    Provider.of<LoadingProvider>(context, listen: false)
        .setUploading(value: true);
    final flutterBkash = FlutterBkash();
    final result = await flutterBkash.createAgreement(
      payerReference: "00",
      context: context,
    );
    

    List<String> bookinglist = prefs!.getStringList("bookingtour")!;
    bookinglist.add(widget.model.id!);

    FirebaseServices.updateData(
        collection: "users",
        id: prefs!.getString("uid")!,
        map: ({
          "bookingtour": bookinglist,
        })).then((value) async {
      await prefs!.setStringList("bookingtour", bookinglist);
      itembookinglist = prefs!.getStringList("bookingtour")!;
      if (saveItemList.contains(widget.model.id)) {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseServices.getUserSnapshot();

        Fluttertoast.showToast(msg: "Item remove successfully.");
        List<dynamic> savetour = userSnapshot["savetour"];
        savetour.remove(widget.model.id);

        await FirebaseServices.updateData(
            id: prefs!.getString("uid")!,
            collection: "users",
            map: ({"savetour": savetour}));

        List<String> savetorFromfirebase =
            savetour.map((dynamic element) => element.toString()).toList();
        await prefs!.setStringList("savetour", savetorFromfirebase);
        saveItemList = prefs!.getStringList("savetour")!;
        setState(() {});
      }

      pushNotificationMessage.sendNotificationUser(token, title, body, userid);
      // ignore: use_build_context_synchronously
      Provider.of<LoadingProvider>(context, listen: false)
          .setUploading(value: false);
      Fluttertoast.showToast(msg: "Booking successfully.");
    }).then((value) {
      FirebaseServices.addBookingTour(
          id: prefs!.getString("uid")!,
          collection: "users",
          subCollect: "boookings",
          subId: id,
          map: ({
            "id": id,
            "uid": prefs!.getString("uid"),
            "bookingtime": DateTime.now()
          })).then((value) async {
        var uploadingData = await FirebaseServices.bookingSnaphsot(
            collection: 'boookings', id: id);

        if (uploadingData.exists) {
          itemList = uploadingData['ui'];
          itemList.add(prefs!.getString("uid")!);
          if (kDebugMode) {
            print(itemList);
          }
          uploadingData.reference.update({'ui': itemList});
        } else {
          itemList.add(prefs!.getString("uid")!);
          await uploadingData.reference.set({"ui": itemList});
        }
      });
    });

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(index: 0),
        ));

    // ignore: use_build_context_synchronously
    globalMethod.showSnackbar(
        context, "(Success) tranId: ${result.payerReference}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "${widget.model.tourname} View",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                if (saveItemList.contains(widget.model.id)) {
                  DocumentSnapshot userSnapshot =
                      await FirebaseServices.getUserSnapshot();
                  Fluttertoast.showToast(msg: "Item remove successfully.");

                  List<dynamic> savetour = userSnapshot["savetour"];
                  savetour.remove(widget.model.id);

                  await FirebaseServices.updateData(
                      id: prefs!.getString("uid")!,
                      collection: "users",
                      map: ({"savetour": savetour}));

                  List<String> savetorFromfirebase = savetour
                      .map((dynamic element) => element.toString())
                      .toList();
                  await prefs!.setStringList("savetour", savetorFromfirebase);
                  saveItemList = prefs!.getStringList("savetour")!;
                  setState(() {});
                } else {
                  List<String> saveListItem = prefs!.getStringList("savetour")!;
                  saveListItem.add(widget.model.id!);

                  FirebaseServices.updateData(
                      id: prefs!.getString("uid")!,
                      collection: "users",
                      map: ({"savetour": saveListItem})).then((value) async {
                    await prefs!.setStringList("savetour", saveListItem);
                    saveItemList = prefs!.getStringList("savetour")!;
                    setState(() {});
                    Fluttertoast.showToast(msg: "Item added successfully.");
                  });
                }
              },
              icon: Icon(
                Ionicons.heart,
                color: saveItemList.contains(widget.model.id)
                    ? Colors.red
                    : const Color.fromRGBO(175, 175, 175, 1),
                size: 40,
              ),
            )
          ]),
      body: Consumer<LoadingProvider>(
        builder: (context, value, child) {
          return value.getUploading == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Consumer<DetailsProvider>(
                      builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChangeImageSildeWidget(
                              value: value,
                              model: widget.model,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(widget.model.tourname!,
                                    overflow: TextOverflow.ellipsis,
                                    //Someis No
                                    style: largeTextStyle.copyWith(
                                      fontSize: 22,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )),
                                const Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: yelloColor,
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(widget.model.rate.toString(),
                                        style: largestTextStyle.copyWith(
                                            color:
                                                Theme.of(context).hintColor)),
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
                                  color: lightTextColor,
                                ),
                                Text(widget.model.location!,
                                    style: mediumTextStyle.copyWith(
                                        color: Theme.of(context).hintColor)),
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
                                  style: mediumTextStyle.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(widget.model.description!,
                                textAlign: TextAlign.justify,
                                style: largestTextStyle.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).hintColor)),
                            const SizedBox(
                              height: 10,
                            ),
                            itembookinglist.contains(widget.model.id)
                                ? Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                233, 233, 233, 1),
                                            width: 1)),
                                    child: Text("Already Boooking",
                                        textAlign: TextAlign.justify,
                                        style: appbarTextStyle.copyWith(
                                            color: white)),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      var documentSnapshot =
                                          await FirebaseFirestore.instance
                                              .collection("admin")
                                              .doc("admin")
                                              .get();

                                      String token =
                                          documentSnapshot["admindivecetoken"];
                                      paymentCheckout(
                                          double.parse(widget.model.cost!),
                                          widget.model.id!,
                                          token,
                                          "Payment",
                                          "${prefs!.getString("username")} is booking to ${widget.model.tourname}",
                                          prefs!.getString("uid")!);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              //chnage
                                              color:
                                                  Theme.of(context).cardColor,
                                              width: 1)),
                                      child: Text(
                                          "Booking Now| \$ ${widget.model.cost}",
                                          textAlign: TextAlign.center,
                                          style: appbarTextStyle.copyWith(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor)),
                                    ),
                                  )
                          ],
                        );
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
