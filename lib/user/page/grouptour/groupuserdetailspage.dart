import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/others/const.dart';
import 'package:tour_apps/others/globalcolor.dart';
import 'package:tour_apps/service/provider/details_provider.dart';
import 'package:tour_apps/service/provider/loading_provider.dart';
import '../../../others/textstyle.dart';
import '../../../model/grouptipmodel.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../service/database/firebaseservice.dart';
import '../../../widget/change_image_silder_widget.dart';
import '../../mainpage.dart';
import '../../../service/other/pushnotificationmessage.dart';

class UserGroupdDetailsPage extends StatefulWidget {
  const UserGroupdDetailsPage({
    super.key,
    required this.model,
  });

  final GroupTourModel model;

  @override
  State<UserGroupdDetailsPage> createState() => _UserGroupdDetailsPageState();
}

class _UserGroupdDetailsPageState extends State<UserGroupdDetailsPage> {
  String bookingid = DateTime.now().millisecondsSinceEpoch.toString();

  PushNotificationMessage pushNotificationMessage = PushNotificationMessage();

  List<dynamic> itemList = [];

  List<String> bookingrouptour = prefs!.getStringList("bookinggroup")!;
  List<String> savegrouptour = prefs!.getStringList("savegrouptour")!;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<DetailsProvider>(context, listen: false)
          .setImage(imageNumber: 0);
    });
    super.initState();
  }

  Future<void> paymentCheckout(double amount, String id, String token,
      String title, String body, String userid) async {
    Provider.of<LoadingProvider>(context, listen: false)
        .setUploading(value: true);
    final flutterBkash = FlutterBkash();
    final result = await flutterBkash.createAgreement(
      payerReference: "00",
      context: context,
    );

    bookingrouptour = prefs!.getStringList("bookinggroup")!;
    bookingrouptour.add(widget.model.id!);

    FirebaseServices.updateData(
        collection: "users",
        id: prefs!.getString("uid")!,
        map: ({
          "bookinggroup": bookingrouptour,
        })).then((value) async {
      await prefs!.setStringList("bookinggroup", bookingrouptour);
      bookingrouptour = prefs!.getStringList("bookinggroup")!;

      if (savegrouptour.contains(widget.model.id)) {
        DocumentSnapshot userSnapshot =
            await FirebaseServices.getUserSnapshot();

        Fluttertoast.showToast(msg: "Item remove successfully.");

        List<dynamic> savetour = userSnapshot["savegrouptour"];
        savetour.remove(widget.model.id);

        await FirebaseServices.updateData(
            id: prefs!.getString("uid")!,
            collection: "users",
            map: ({"savegrouptour": savetour}));

        List<String> savetorFromfirebase =
            savetour.map((dynamic element) => element.toString()).toList();

        await prefs!.setStringList("savegrouptour", savetorFromfirebase);
        savegrouptour = prefs!.getStringList("savegrouptour")!;
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
          subCollect: "bookinggroup",
          subId: id,
          map: ({
            "id": id,
            "uid": prefs!.getString("uid"),
            "bookingtime": DateTime.now()
          })).then((value) async {
        var uploadingData = await FirebaseFirestore.instance
            .collection("bookinggroup")
            .doc(id)
            .get();

        if (uploadingData.exists) {
          itemList = uploadingData['ui'];
          itemList.add(prefs!.getString("uid")!);
          if (kDebugMode) {
            print(itemList);
          }
          await uploadingData.reference.update({'ui': itemList});
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.model.tourname} View",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              if (savegrouptour.contains(widget.model.id)) {
                DocumentSnapshot userSnapshot =
                    await FirebaseServices.getUserSnapshot();
                Fluttertoast.showToast(msg: "Item remove successfully.");

                List<dynamic> savegroup = userSnapshot["savegrouptour"];
                savegroup.remove(widget.model.id);

                await FirebaseServices.updateData(
                    id: prefs!.getString("uid")!,
                    collection: "users",
                    map: ({"savegrouptour": savegroup}));

                List<String> savetorFromfirebase = savegroup
                    .map((dynamic element) => element.toString())
                    .toList();
                await prefs!
                    .setStringList("savegrouptour", savetorFromfirebase);
                savegrouptour = prefs!.getStringList("savegrouptour")!;
                setState(() {});
              } else {
                List<String> saveListItem =
                    prefs!.getStringList("savegrouptour")!;
                saveListItem.add(widget.model.id!);

                FirebaseServices.updateData(
                    id: prefs!.getString("uid")!,
                    collection: "users",
                    map: ({"savegrouptour": saveListItem})).then((value) async {
                  await prefs!.setStringList("savegrouptour", saveListItem);
                  savegrouptour = prefs!.getStringList("savegrouptour")!;
                  setState(() {});
                  Fluttertoast.showToast(msg: "Item added successfully.");
                });
              }
            },
            icon: Icon(
              Ionicons.heart,
              color: savegrouptour.contains(widget.model.id)
                  ? Colors.red
                  : const Color.fromRGBO(175, 175, 175, 1),
              size: 40,
            ),
          )
        ],
      ),
      body: Consumer<LoadingProvider>(
        builder: (context, value, child) {
          return value.getUploading == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Consumer<DetailsProvider>(
                      builder: (context, imagesilder, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChangeImageSildeWidget(
                              value: imagesilder,
                              model: widget.model,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(widget.model.tourname!,
                                    overflow: TextOverflow.ellipsis,
                                    //fjaljflkajlkdjlaf
                                    style: largeTextStyle.copyWith(
                                      fontSize: 22,
                                      color: Theme.of(context).cardColor,
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
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                Text(
                                  widget.model.location!,
                                  style: mediumTextStyle.copyWith(
                                      color: Theme.of(context).hintColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                        widget.model.tourdate!.toDate()),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.model.duration!,
                                    style: mediumTextStyle.copyWith(
                                        color: Theme.of(context).cardColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.model.description!,
                              textAlign: TextAlign.justify,
                              style: largestTextStyle.copyWith(
                                  fontSize: 15,
                                  color: Theme.of(context).hintColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            bookingrouptour.contains(widget.model.id)
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
                                      // sendNotificationToAdmin(widget.model.id, "Bangladesh","What are you doing now");

                                      var documentSnapshot =
                                          await FirebaseFirestore.instance
                                              .collection("admin")
                                              .doc("admin")
                                              .get();

                                      String token =
                                          documentSnapshot["admindivecetoken"];

                                      paymentCheckout(
                                          widget.model.cost!,
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
                                  ),
                            const SizedBox(
                              height: 50,
                            ),
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
