import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import '../../../service/database/firebaseservice.dart';
import '../../../widget/loading_tour_widget.dart';
import '../../../others/const.dart';
import '../../../others/textstyle.dart';
import '../../../model/tourmodel.dart';
import '../../../widget/row_widget.dart';
import '../../../widget/empty_widget.dart';
import 'bookingroupbooking.dart';
import 'bookingtourwidget.dart';

class BookingTour extends StatefulWidget {
  const BookingTour({super.key});
  @override
  State<BookingTour> createState() => _BookingTourState();
}

class _BookingTourState extends State<BookingTour> {
  List<String> usergroupbooking = prefs!.getStringList("bookinggroup")!;
  List<String> usersinglebooking = prefs!.getStringList("bookingtour")!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Tour", style: appbarTextStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            RowWidget(
              text: 'Single Tour',
              funtion: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .45,
              child: usersinglebooking.first == "tourapp" &&
                      usersinglebooking.length == 1
                  ? const EmptyWidget(
                      image: "asset/image/empty.png",
                      text: 'No Group Tour Booking',
                    )
                  : StreamBuilder(
                      stream: FirebaseServices.getAllDataWithWhere(
                          collection: "trip", list: usersinglebooking),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'Error: ${snapshot.error}',
                          );
                        } else if (!snapshot.hasData) {
                          return const EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'No Group Tour Booking',
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingTourWidget();
                        } else if (snapshot.hasData) {
                          List<String> tourBookingIds = [];

                          for (var doc in snapshot.data!.docs) {
                            tourBookingIds.add(doc.id);
                          }

                          return ListView.builder(
                            itemCount: tourBookingIds.length,
                            itemBuilder: (context, index) {
                              TourModel tourModel = TourModel.fromMap(
                                  snapshot.data!.docs[index].data());

                              if (tourModel.tourdate!.microsecondsSinceEpoch <=
                                  Timestamp.fromDate(DateTime.now())
                                      .microsecondsSinceEpoch) {
                                List<String> historyListitem =
                                    prefs!.getStringList("historytour")!;
                                historyListitem.add(tourModel.id!);

                                FirebaseServices.updateData(
                                        id: prefs!.getString("uid")!,
                                        collection: "users",
                                        map: ({"historytour": historyListitem}))
                                    .then((value) async {
                                  await prefs!.setStringList(
                                      "historytour", historyListitem);

                                  List<String> bookinglist =
                                      prefs!.getStringList("bookingtour")!;
                                  bookinglist.remove(tourModel.id!);

                                  FirebaseServices.updateData(
                                          id: prefs!.getString("uid")!,
                                          collection: "users",
                                          map: ({"bookingtour": bookinglist}))
                                      .then((value) async {
                                    await prefs!.setStringList(
                                        "bookingtour", bookinglist);
                                  });
                                });
                              } else {
                                return ChangeNotifierProvider.value(
                                  value: tourModel,
                                  child: const BookingTourWidget(),
                                );
                              }
                              return null;
                            },
                          );
                        }
                        return const EmptyWidget(
                          image: "asset/image/empty.png",
                          text: 'No Group Tour Booking',
                        );
                      },
                    ),
            ),
            RowWidget(
              text: 'Group Tour',
              funtion: () {},
            ),
            Expanded(
              child: usergroupbooking.first == "tourapp" &&
                      usergroupbooking.length == 1
                  ? const EmptyWidget(
                      image: "asset/image/empty.png",
                      text: 'No Group Tour Save',
                    )
                  : StreamBuilder(
                      stream: FirebaseServices.getAllDataWithWhere(
                          collection: "grouptrips", list: usergroupbooking),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'Error: ${snapshot.error}',
                          );
                        } else if (!snapshot.hasData) {
                          return const EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'No Single Booking Save',
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingTourWidget();
                        } else if (snapshot.hasData) {
                          List<String> grouptourid = [];
                          for (var doc in snapshot.data!.docs) {
                            grouptourid.add(doc.id);
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: grouptourid.length,
                            itemBuilder: (context, index) {
                              GroupTourModel tourModel = GroupTourModel.fromMap(
                                  snapshot.data!.docs[index].data());
                              if (tourModel.tourdate!.microsecondsSinceEpoch <=
                                  Timestamp.fromDate(DateTime.now())
                                      .microsecondsSinceEpoch) {
                                List<String> historyListitem =
                                    prefs!.getStringList("historygrouptour")!;

                                historyListitem.add(tourModel.id!);

                                FirebaseServices.updateData(
                                    id: prefs!.getString("uid")!,
                                    collection: "users",
                                    map: ({
                                      "historygrouptour": historyListitem
                                    })).then((value) async {
                                  await prefs!.setStringList(
                                      "historygrouptour", historyListitem);

                                  List<String> bookinglist =
                                      prefs!.getStringList("bookinggroup")!;
                                  bookinglist.remove(tourModel.id!);

                                  FirebaseServices.updateData(
                                          id: prefs!.getString("uid")!,
                                          collection: "users",
                                          map: ({"bookinggroup": bookinglist}))
                                      .then((value) async {
                                    await prefs!.setStringList(
                                        "bookinggroup", bookinglist);
                                  });
                                });
                              } else {
                                return ChangeNotifierProvider.value(
                                  value: tourModel,
                                  child: const BookingGroupWidget(),
                                );
                              }
                              return Container();
                            },
                          );
                        }

                        return const LoadingTourWidget();
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
