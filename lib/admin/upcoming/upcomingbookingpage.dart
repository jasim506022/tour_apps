import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import 'package:tour_apps/widget/loading_tour_widget.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import '../../model/tourmodel.dart';
import '../../widget/row_widget.dart';
import 'booking_group_widget_admin.dart';
import 'booking_tour_widget_admin.dart';

class UpcomingBookingTourPage extends StatefulWidget {
  const UpcomingBookingTourPage({super.key});
  @override
  State<UpcomingBookingTourPage> createState() =>
      _UpcomingBookingTourPageState();
}

class _UpcomingBookingTourPageState extends State<UpcomingBookingTourPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Upcoming Booking Tour",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            RowWidget(
              text: 'Single Tour',
              funtion: () {},
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: StreamBuilder(
                stream: FirebaseServices.getAllDataSnapshots(
                    collection: "boookings"),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const LoadingTourWidget();
                  } else if (snap.hasData) {
                    final bookingIds =
                        snap.data!.docs.map((doc) => doc.id).toList();
                    return StreamBuilder(
                      stream: FirebaseServices.getAllDataWithWhere(
                          collection: "trip", list: bookingIds),
                      builder: (context, tripSnapshot) {
                        if (tripSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingTourWidget();
                        }
                        final tourModels = tripSnapshot.data!.docs.map((doc) {
                          final tourData = doc.data();
                          return TourModel.fromMap(tourData);
                        }).toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: tourModels.length,
                          itemBuilder: (context, index) {
                            List<dynamic> data = snap.data!.docs[index]['ui'];
                            return ChangeNotifierProvider.value(
                              value: tourModels[index],
                              child: BookingTourWidgetAdmin(
                                uid: data,
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const LoadingTourWidget();
                },
              ),
            ),
            RowWidget(
              text: 'Group Tour',
              funtion: () {},
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseServices.getAllDataSnapshots(
                    collection: "bookinggroup"),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const LoadingTourWidget();
                  } else if (snap.hasData) {
                    final bookingIds =
                        snap.data!.docs.map((doc) => doc.id).toList();

                    return StreamBuilder(
                      stream: FirebaseServices.getAllDataWithWhere(
                          collection: "grouptrips",  list: bookingIds),
                      builder: (context, tripSnapshot) {
                        if (tripSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingTourWidget();
                        }
                        List<GroupTourModel> tourModels =
                            tripSnapshot.data!.docs.map((doc) {
                          final tourData = doc.data();
                          return GroupTourModel.fromMap(tourData);
                        }).toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: tourModels.length,
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider.value(
                              value: tourModels[index],
                              child: BookingGroupWidgetAdmin(
                                uid: snap.data!.docs[index]['ui'],
                              ),
                            );
                          },
                        );
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
