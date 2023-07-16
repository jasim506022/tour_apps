import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_apps/model/grouptipmodel.dart';

import '../../../const/const.dart';
import '../../../widget/grouptips.dart';
import 'uploadgroupstrispadmin.dart';

class GroupTripsAdminPage extends StatefulWidget {
  const GroupTripsAdminPage({super.key});

  @override
  State<GroupTripsAdminPage> createState() => _GroupTripsAdminPageState();
}

class _GroupTripsAdminPageState extends State<GroupTripsAdminPage> {
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
                      builder: (context) => const UploadGroupTripsPageAdmin(),
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
                    snapshot.data!.docs[index].data());

                return GroupTripsWidget(
                  groupTipsModel: model,
                );
              },
            );
          }

          return const Text("No Data Found");
        },
      ),
    );
  }
}
