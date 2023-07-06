import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_apps/model/grouptipmodel.dart';

import '../../../const/const.dart';
import '../../../widget/grouptips.dart';
import 'uploadgroupstrisp.dart';

class GroupTripsPage extends StatefulWidget {
  const GroupTripsPage({super.key});

  @override
  State<GroupTripsPage> createState() => _GroupTripsPageState();
}

class _GroupTripsPageState extends State<GroupTripsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Group Trips",
          style: appbarTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UploadGroupTripsPage(),
                    ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("grouptrips")
            .orderBy("publishdate", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                GroupTipsModelFirebase model = GroupTipsModelFirebase.fromMap(
                    snapshot.data!.docs[index].data() as Map<String, dynamic>);

                return GroupTripsWidget(
                  groupTipsModel: model,
                );
              },
            );
          }

          return Text("No Data Found");
        },
      ),
    );
  }
}
