import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_apps/admin/upcoming/photo_widget.dart';
import 'package:tour_apps/widget/loading_tour_widget.dart';
import '../../model/profiledatamodel.dart';

class NumberOfUserBookingPage extends StatefulWidget {
  const NumberOfUserBookingPage(
      {super.key,
      required this.uid,
      required this.tourName,
      required this.ids});
  final List<dynamic> uid;
  final String tourName;
  final String ids;

  @override
  State<NumberOfUserBookingPage> createState() =>
      _NumberOfUserBookingPageState();
}

class _NumberOfUserBookingPageState extends State<NumberOfUserBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tourName),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("users")
            .where('uid', whereIn: widget.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingTourWidget();
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                ProfileDataModel profileDataModel =
                    ProfileDataModel.fromMap(snapshot.data!.docs[index].data());
                return PhotoWidget(
                  profileMode: profileDataModel,
                );
              },
            );
          }
          return const LoadingTourWidget();
        },
      ),
    );
  }
}
