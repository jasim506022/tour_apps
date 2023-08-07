import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/admin/group/searchpageaddmin.dart';
import 'package:tour_apps/model/grouptipmodel.dart';

import '../../../const/const.dart';
import '../../user/widget/grouptips.dart';
import '../../user/widget/loading_group_widget.dart';
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
                      builder: (context) =>
                          UploadGroupTripsPageAdmin(isUPdate: false),
                    ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupSearchScreen(),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Text("Search Here",
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: black)),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("grouptrips")
                  .orderBy("publishdate", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingGroupdWidget();
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      GroupTourModel model = GroupTourModel.fromMap(
                          snapshot.data!.docs[index].data());

                      return ChangeNotifierProvider.value(
                        value: model,
                        child: const GroupTourWidget(),
                      );
                    },
                  );
                }

                return const LoadingGroupdWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
